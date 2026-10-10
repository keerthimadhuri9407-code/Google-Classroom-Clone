// import 'package:flutter/material.dart';
// import 'login_screen.dart';

// class ProfileScreen extends StatelessWidget {
//   final String userEmail;

//   const ProfileScreen({
//     super.key,
//     required this.userEmail,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Profile"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment:
//               MainAxisAlignment.center,
//           children: [
//             const CircleAvatar(
//               radius: 50,
//               child: Icon(
//                 Icons.person,
//                 size: 50,
//               ),
//             ),

//             const SizedBox(height: 20),

//              Text(
//   userEmail,
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             const Text(
//               "IT Student",
//             ),

//             const SizedBox(height: 20),

//             ElevatedButton.icon(
//               onPressed: () {
//   Navigator.pushAndRemoveUntil(
//     context,
//     MaterialPageRoute(
//       builder: (context) => const LoginScreen(),
//     ),
//     (route) => false,
//   );
// },
//               icon: const Icon(Icons.logout),
//               label: const Text("Logout"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'email_notifications_screen.dart';

class ProfileScreen extends StatelessWidget {
  final String userEmail;
  
  const ProfileScreen({
    super.key,
    required this.userEmail,
  });

  String get displayName {
    final username = userEmail.split('@').first;
    return username
        .replaceAll(RegExp(r'[._-]+'), ' ')
        .split(' ')
        .map((word) => word.isEmpty
            ? ''
            : '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFF5F7FB),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF4285F4),
                    Color(0xFF174EA6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.white,
                    child: Text(
                      displayName.isNotEmpty
                          ? displayName[0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4285F4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    displayName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    userEmail,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Student Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Account details
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Account Information',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ),

            const SizedBox(height: 14),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFE4EDFF),
                      child: Icon(
                        Icons.person_outline,
                        color: Color(0xFF4285F4),
                      ),
                    ),
                    title: const Text('Display Name'),
                    subtitle: Text(displayName),
                  ),
                  const Divider(indent: 20, endIndent: 20),
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFE4EDFF),
                      child: Icon(
                        Icons.email_outlined,
                        color: Color(0xFF4285F4),
                      ),
                    ),
                    title: const Text('Email Address'),
                    subtitle: Text(userEmail),
                  ),
                  const Divider(indent: 20, endIndent: 20),
                  const ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(0xFFE4EDFF),
                      child: Icon(
                        Icons.school_outlined,
                        color: Color(0xFF4285F4),
                      ),
                    ),
                    title: Text('Role'),
                    subtitle: Text('Student'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            // Email Notifications option
Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
  ),
  child: ListTile(
    leading: const CircleAvatar(
      backgroundColor: Color(0xFFE4EDFF),
      child: Icon(
        Icons.notifications_active_outlined,
        color: Color(0xFF4285F4),
      ),
    ),
    title: const Text(
      'Email Notifications',
      style: TextStyle(
        fontWeight: FontWeight.w600,
      ),
    ),
    subtitle: const Text(
      'Manage assignment email alerts',
    ),
    trailing: const Icon(Icons.chevron_right),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const EmailNotificationsScreen(),
        ),
      );
    },
  ),
),

const SizedBox(height: 20),
            // Logout button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout_rounded),
                label: const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red.shade700,
                  side: BorderSide(
                    color: Colors.red.shade200,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
