
require('dotenv').config();

const express = require('express');
const cors = require('cors');
const rateLimit = require('express-rate-limit');
const { GoogleGenAI } = require('@google/genai');
const { Resend } = require('resend');
const { initializeApp, applicationDefault, getApps } =
  require('firebase-admin/app');
const { getAuth } = require('firebase-admin/auth');
const { getFirestore } = require('firebase-admin/firestore');
const app = express();

app.use(cors());
app.use(express.json({ limit: '20kb' }));
app.use(rateLimit({
  windowMs: 60 * 1000,
  limit: 10,
  standardHeaders: true,
  legacyHeaders: false,
}));

// Firebase Admin uses Application Default Credentials
// when deployed on a supported hosting environment.
const firebaseApp = getApps().length
  ? getApps()[0]
  : initializeApp({
      credential: applicationDefault(),
    });

const auth = getAuth(firebaseApp);
const db = getFirestore(firebaseApp);

const ai = new GoogleGenAI({
  apiKey: process.env.GEMINI_API_KEY,
});
const resend = new Resend(process.env.RESEND_API_KEY);
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send('Smart Classroom AI backend is running.');
});

app.post('/chat', async (req, res) => {
  try {
    const authHeader = req.headers.authorization || '';
    const token = authHeader.startsWith('Bearer ')
      ? authHeader.substring(7)
      : '';

    if (!token) {
      return res.status(401).json({
        error: 'Please sign in to use the chatbot.',
      });
    }

    const user = await auth.verifyIdToken(token);
    const message = req.body.message;

    if (typeof message !== 'string' || !message.trim()) {
      return res.status(400).json({
        error: 'Please enter a question.',
      });
    }

    if (message.length > 4000) {
      return res.status(400).json({
        error: 'Your question is too long.',
      });
    }

    // Verify that the user has a Firestore profile.
    const userDoc = await db.collection('users').doc(user.uid).get();

    if (!userDoc.exists) {
      return res.status(403).json({
        error: 'Your student profile was not found.',
      });
    }

    // Optional course material supplied by the caller.
    // Real Firestore resource retrieval will be added next.
    const courseMaterial =
      typeof req.body.courseMaterial === 'string'
        ? req.body.courseMaterial.slice(0, 10000)
        : '';

    const prompt = `
You are a helpful study assistant in a Smart Classroom app.
Explain concepts clearly and accurately.
If classroom material is supplied, use it when relevant.
Distinguish information from the supplied material from general knowledge.

${courseMaterial
  ? `Classroom material:\n${courseMaterial}`
  : 'No classroom material was supplied for this question.'}

Student question:
${message.trim()}
`;

    const response = await ai.models.generateContent({
      model: 'gemini-2.5-flash',
      contents: prompt,
    });

    return res.json({
      reply: response.text ||
        'Sorry, I could not generate an answer.',
    });
  } catch (error) {
    console.error('Chat request failed:', error.message);

    return res.status(500).json({
      error: 'Unable to answer right now. Please try again.',
    });
  }
});

app.post('/test-email', async (req, res) => {
  try {
    const authHeader = req.headers.authorization || '';
    const token = authHeader.startsWith('Bearer ')
      ? authHeader.substring(7)
      : '';

    if (!token) {
      return res.status(401).json({
        error: 'Please sign in first.',
      });
    }

    const user = await auth.verifyIdToken(token);
    const userDoc = await db.collection('users')
      .doc(user.uid).get();

    if (!userDoc.exists) {
      return res.status(403).json({
        error: 'Student profile not found.',
      });
    }

    const email = user.email;

    if (!email) {
      return res.status(400).json({
        error: 'Your account has no email address.',
      });
    }

    const result = await resend.emails.send({
      from: 'Google Classroom <onboarding@resend.dev>',
      to: email,
      subject: 'Google Classroom Email Test',
      html: `
        <h2>Email notifications are working!</h2>
        <p>This is a test email from your Google Classroom app.</p>
        <p>You can receive assignment announcements and reminders
        once those features are connected.</p>
      `,
    });

    if (result.error) {
      console.error('Resend error:', result.error);
  return res.status(502).json({
    error: 'Email could not be sent.',
  });
    }

    return res.json({
      message: 'Email accepted by Resend.',
    });
  } catch (error) {
    console.error('Email request failed:', error.message);
    return res.status(500).json({
      error: 'Unable to send email.',
    });
  }
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Smart Classroom backend listening on port ${PORT}`);
});
