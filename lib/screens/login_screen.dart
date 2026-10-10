// import 'package:flutter/material.dart';
// import 'dashboard_screen.dart';


// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final emailController = TextEditingController();
//     final passwordController = TextEditingController();

//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   height: 120,
//                   width: 120,
//                   decoration: BoxDecoration(
//                   color: Colors.blue[100],
//                   shape: BoxShape.circle,
//                 ),
//               child: const Icon(
//                 Icons.school,
//                 size: 70,
//                 color: Colors.blue,
//                 ),
//               ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   "Google Classroom",
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 TextField(
//   controller: emailController,
//   keyboardType: TextInputType.emailAddress,
//   decoration: InputDecoration(
//     labelText: "Email",
//     hintText: "example@gmail.com",
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(15),
//     ),
//   ),
// ),
//                 const SizedBox(height: 15),
//                 TextField(
//                   controller: passwordController,
//                   obscureText: true,
//                   decoration: InputDecoration(
//   labelText: "Password",
//   border: OutlineInputBorder(
//     borderRadius: BorderRadius.circular(15),
//   ),
// ),
                  
//                 ),
//                 const SizedBox(height: 20),
//                 SizedBox(
//   width: double.infinity,
//   child: ElevatedButton(
//     style: ElevatedButton.styleFrom(
//       minimumSize: const Size(double.infinity, 55),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//     ),
//     onPressed: () {
//   final email = emailController.text.trim();
//   final password = passwordController.text.trim();

//   if (email.isEmpty) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text("Please enter your email"),
//       ),
//     );
//     return;
//   }

//   if (!email.contains('@') || !email.contains('.')) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text("Please enter a valid email"),
//       ),
//     );
//     return;
//   }

//   if (password.isEmpty) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text("Please enter your password"),
//       ),
//     );
//     return;
//   }

//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => DashboardScreen(
//         userEmail: email,
//       ),
//     ),
//   );
// },
//     child: const Text(
//       "LOGIN",
//       style: TextStyle(
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//   ),
// ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  
Future<void> login() async {
  final email = emailController.text.trim();
  final password = passwordController.text;

  final emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  if (!emailPattern.hasMatch(email)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enter a valid email address')),
    );
    return;
  }

  if (password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enter your password')),
    );
    return;
  }

  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => DashboardScreen(
          userEmail: credential.user!.email ?? email,
        ),
      ),
    );
  } on FirebaseAuthException catch (e) {
    if (!mounted) return;

    String message;

    switch (e.code) {
      case 'user-not-found':
      case 'invalid-credential':
        message = 'No account found, or the password is incorrect.';
        break;
      case 'wrong-password':
        message = 'Incorrect password.';
        break;
      case 'invalid-email':
        message = 'Please enter a valid email address.';
        break;
      case 'too-many-requests':
        message = 'Too many attempts. Please try again later.';
        break;
      default:
        message = e.message ?? 'Login failed. Please try again.';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  } catch (_) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Something went wrong. Please try again.'),
      ),
    );
  }
}

Future<void> register() async {
  final email = emailController.text.trim();
  final password = passwordController.text;

  if (email.isEmpty || !email.contains('@')) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Enter a valid email address')),
    );
    return;
  }

  if (password.length < 6) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password must contain at least 6 characters'),
      ),
    );
    return;
  }

  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Account created! You can now sign in.'),
      ),
    );

    passwordController.clear();
  } on FirebaseAuthException catch (e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.message ?? 'Registration failed'),
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 30,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Column(
                children: [
                  const SizedBox(height: 15),

                  // App logo
                  Container(
                    height: 105,
                    width: 105,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF4285F4),
                          Color(0xFF174EA6),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withValues(alpha: 0.22),
                          blurRadius: 25,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.school_rounded,
                      size: 58,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 28),

                  const Text(
                    'Welcome to Classroom',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF202124),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Learn, collaborate and stay organized.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF70757A),
                    ),
                  ),

                  const SizedBox(height: 35),

                  // Login card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 25,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF202124),
                          ),
                        ),

                        const SizedBox(height: 22),

                        // Email field
                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Email address',
                            hintText: 'you@example.com',
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: Color(0xFF4285F4),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF7F9FC),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Color(0xFFE8EDF5),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Color(0xFF4285F4),
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Password field
                        TextField(
                          controller: passwordController,
                          obscureText: hidePassword,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => login(),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Color(0xFF4285F4),
                            ),
                            suffixIcon: IconButton(
                              tooltip: hidePassword
                                  ? 'Show password'
                                  : 'Hide password',
                              icon: Icon(
                                hidePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF7F9FC),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Color(0xFFE8EDF5),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Color(0xFF4285F4),
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 25),

                        // Sign in button
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4285F4),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(Icons.arrow_forward_rounded),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
Center(
  child: TextButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        ),
      );
    },
    child: const Text(
      'New student? Create account',
      style: TextStyle(
        color: Color(0xFF4285F4),
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
),

                  const SizedBox(height: 25),

                  const Text(
                    'Your classroom, all in one place.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF70757A),
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
