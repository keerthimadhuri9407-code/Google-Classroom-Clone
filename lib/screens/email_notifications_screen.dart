
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailNotificationsScreen extends StatefulWidget {
  const EmailNotificationsScreen({super.key});

  @override
  State<EmailNotificationsScreen> createState() =>
      _EmailNotificationsScreenState();
}

class _EmailNotificationsScreenState
    extends State<EmailNotificationsScreen> {
  bool assignmentEmails = true;
  bool deadlineReminders = true;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      if (mounted) setState(() => isLoading = false);
      return;
    }

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final data = doc.data() ?? {};

      if (mounted) {
        setState(() {
          assignmentEmails =
              data['assignmentEmails'] as bool? ?? true;
          deadlineReminders =
              data['deadlineReminders'] as bool? ?? true;
          isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => isLoading = false);
    }
  }
  Future<void> sendTestEmail() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please sign in first')),
    );
    return;
  }

  try {
    final token = await user.getIdToken();

    final response = await http.post(
      Uri.parse('http://localhost:3000/test-email'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({}),
    );

    final data = jsonDecode(response.body);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          response.statusCode == 200
              ? 'Test email sent successfully!'
              : data['error'] ?? 'Failed to send email',
        ),
      ),
    );
  
} catch (e) {
  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Connection error: $e'),
      duration: const Duration(seconds: 8),
    ),
  );
}

}
  Future<void> savePreference(String field, bool value) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({field: value}, SetOptions(merge: true));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Preference saved')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not save preference. Try again.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Notifications'),
        backgroundColor: const Color(0xFF1967D2),
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Icon(
                  Icons.mark_email_read_outlined,
                  size: 64,
                  color: Color(0xFF1967D2),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Stay updated with your classes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                SwitchListTile(
                  title: const Text('Assignment announcements'),
                  subtitle: const Text(
                    'Receive emails about new assignments.',
                  ),
                  value: assignmentEmails,
                  onChanged: (value) async {
                    setState(() => assignmentEmails = value);
                    await savePreference('assignmentEmails', value);
                  },
                ),
                const Divider(),
                               SwitchListTile(
                  title: const Text('Deadline reminders'),
                  subtitle: const Text(
                    'Receive emails about upcoming deadlines.',
                  ),
                  value: deadlineReminders,
                  onChanged: (value) async {
                    setState(() => deadlineReminders = value);
                    await savePreference('deadlineReminders', value);
                  },
                ),

                const SizedBox(height: 24),

                ElevatedButton.icon(
                  onPressed: sendTestEmail,
                  icon: const Icon(Icons.email),
                  label: const Text('Send Test Email'),
                ),
              ],
            ),
    );
  }
}
    //           ],
    //         ),
    // );
//   }
// }