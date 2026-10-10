// import 'package:flutter/material.dart';
// import 'home_screen.dart';
// import 'profile_screen.dart';

// class DashboardScreen extends StatefulWidget {
//   final String userEmail;

//   const DashboardScreen({
//     super.key,
//     required this.userEmail,
//   });

//   @override
//   State<DashboardScreen> createState() =>
//       _DashboardScreenState();
// }

// class _DashboardScreenState
//     extends State<DashboardScreen> {

//   int currentIndex = 0;

//   late final List<Widget> pages;

// @override
// void initState() {
//   super.initState();

//   pages = [
//     const HomeScreen(),
//     const AssignmentsScreen(),
//     ProfileScreen(
//       userEmail: widget.userEmail,
//     ),
//   ];
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: pages[currentIndex],

//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: currentIndex,

//         onTap: (index) {
//           setState(() {
//             currentIndex = index;
//           });
//         },

//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.class_),
//             label: "Classes",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.assignment),
//             label: "Tasks",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: "Profile",
//           ),
//         ],
//       ),
//     );
//   }
// }

// class AssignmentsScreen extends StatelessWidget {
//   const AssignmentsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Assignments"),
//       ),
//       body: ListView(
//         children: const [
//           Card(
//             margin: EdgeInsets.all(10),
//             child: ListTile(
//               leading: Icon(Icons.assignment),
//               title: Text("DBMS Assignment"),
//               subtitle: Text("Due Tomorrow"),
//             ),
//           ),
//           Card(
//             margin: EdgeInsets.all(10),
//             child: ListTile(
//               leading: Icon(Icons.quiz),
//               title: Text("OS Quiz"),
//               subtitle: Text("Due Friday"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'profile_screen.dart';


class DashboardScreen extends StatefulWidget {
  final String userEmail;

  const DashboardScreen({
    super.key,
    required this.userEmail,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      const HomeScreen(),
      const AssignmentsScreen(),
      ProfileScreen(
        userEmail: widget.userEmail,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.class_),
            label: "Classes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: "Tasks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}


class AssignmentsScreen extends StatelessWidget {
  const AssignmentsScreen({super.key});

  final List<Map<String, dynamic>> assignments = const [
    {
      'title': 'Java Programming',
      'subtitle': 'Complete the inheritance assignment',
      'subject': 'Computer Science',
      'due': 'Due tomorrow',
      'status': 'Pending',
      'icon': Icons.code,
      'color': Color(0xFF536DFE),
    },
    {
      'title': 'Database Management',
      'subtitle': 'Write SQL queries and submit the output',
      'subject': 'DBMS',
      'due': 'Due Oct 15',
      'status': 'Pending',
      'icon': Icons.storage_rounded,
      'color': Color(0xFF009688),
    },
    {
      'title': 'Web Programming',
      'subtitle': 'Create a responsive HTML page',
      'subject': 'Web Technologies',
      'due': 'Submitted',
      'status': 'Completed',
      'icon': Icons.language_rounded,
      'color': Color(0xFFFF9800),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Assignments',
          style: TextStyle(
            color: Color(0xFF202124),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        iconTheme: const IconThemeData(color: Color(0xFF202124)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4263EB), Color(0xFF748FFC)],
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.assignment_turned_in_rounded,
                  color: Colors.white,
                  size: 34,
                ),
                SizedBox(height: 16),
                Text(
                  'Stay on top of your work',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'View your tasks and submission status.',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 26),
          const Text(
            'Your coursework',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color(0xFF202124),
            ),
          ),
          const SizedBox(height: 14),
          ...assignments.map((assignment) {
            final bool completed = assignment['status'] == 'Completed';
            final Color color = assignment['color'] as Color;

            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE8EAF0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          assignment['icon'] as IconData,
                          color: color,
                          size: 25,
                        ),
                      ),
                      const SizedBox(width: 13),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              assignment['title'] as String,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              assignment['subject'] as String,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        completed
                            ? Icons.check_circle_rounded
                            : Icons.schedule_rounded,
                        color: completed ? Colors.green : Colors.orange,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    assignment['subtitle'] as String,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF5F6368),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Icon(
                        completed
                            ? Icons.check_circle_outline
                            : Icons.calendar_month_outlined,
                        size: 16,
                        color: completed ? Colors.green : Colors.black54,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          assignment['due'] as String,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: completed
                              ? const Color(0xFFE6F4EA)
                              : const Color(0xFFFFF0D9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          assignment['status'] as String,
                          style: TextStyle(
                            color: completed
                                ? const Color(0xFF188038)
                                : const Color(0xFFB06000),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
