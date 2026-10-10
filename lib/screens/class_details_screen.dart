// import 'package:flutter/material.dart';

// class ClassDetailsScreen extends StatelessWidget {
//   final String className;

//   const ClassDetailsScreen({
//     super.key,
//     required this.className,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(className),
//           bottom: const TabBar(
//             tabs: [
//               Tab(text: "Stream"),
//               Tab(text: "Classwork"),
//               Tab(text: "People"),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             _streamTab(),
//             _classworkTab(),
//             _peopleTab(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _streamTab() {
//     return ListView(
//       padding: const EdgeInsets.all(16),
//       children: [
//         Container(
//           height: 170,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             gradient: const LinearGradient(
//               colors: [Colors.blueAccent, Colors.blue],
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment:
//                   CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   className,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   "Welcome to your classroom",
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),

//         const SizedBox(height: 20),

//         Card(
//           child: ListTile(
//             leading: CircleAvatar(
//               backgroundColor: Colors.blue,
//               child: Icon(
//                 Icons.campaign,
//                 color: Colors.white,
//               ),
//             ),
//             title: Text("Announcement"),
//             subtitle: Text(
//               "Assignment-1 uploaded. Submit before Friday.",
//             ),
//           ),
//         ),

//         Card(
//           child: ListTile(
//             leading: CircleAvatar(
//               backgroundColor: Colors.blue,
//               child: Icon(
//                 Icons.assignment,
//                 color: Colors.white,
//               ),
//             ),
//             title: Text("New Assignment"),
//             subtitle: Text(
//               "DBMS ER Diagram Submission",
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _classworkTab() {
//     return ListView(
//       padding: const EdgeInsets.all(16),
//       children: const [
//         Card(
//           child: ListTile(
//             leading: Icon(Icons.assignment),
//             title: Text("Assignment 1"),
//             subtitle: Text("Due: Oct 10"),
//           ),
//         ),
//         Card(
//           child: ListTile(
//             leading: Icon(Icons.quiz),
//             title: Text("Quiz 1"),
//             subtitle: Text("Due: Oct 12"),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _peopleTab() {
//     return ListView(
//       padding: const EdgeInsets.all(16),
//       children: const [
//         Text(
//           "Teacher",
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         ListTile(
//           leading: CircleAvatar(
//             child: Icon(Icons.person),
//           ),
//           title: Text("Faculty"),
//         ),
//         Divider(),
//         Text(
//           "Students",
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         ListTile(
//           leading: CircleAvatar(
//             child: Icon(Icons.person_outline),
//           ),
//           title: Text("Student 1"),
//         ),
//         ListTile(
//           leading: CircleAvatar(
//             child: Icon(Icons.person_outline),
//           ),
//           title: Text("Student 2"),
//         ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';

class ClassDetailsScreen extends StatefulWidget {
  final String className;

  const ClassDetailsScreen({
    super.key,
    required this.className,
  });

  @override
  State<ClassDetailsScreen> createState() =>
      _ClassDetailsScreenState();
}

class _ClassDetailsScreenState extends State<ClassDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  final List<Map<String, String>> assignments = [
    {
      'title': 'Assignment 1',
      'description': 'Complete the first assignment.',
      'due': 'Due tomorrow',
    },
    {
      'title': 'Unit Test Preparation',
      'description': 'Prepare notes for the upcoming test.',
      'due': 'Due Friday',
    },
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF202124),
        elevation: 0,
        title: Text(
          widget.className,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // Classroom banner
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(24),
            height: 170,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF4285F4),
                  Color(0xFF174EA6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Icon(
                    Icons.school_rounded,
                    size: 100,
                    color: Colors.white.withValues(alpha: 0.16),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'YOUR CLASSROOM',
                      style: TextStyle(
                        color: Colors.white70,
                        letterSpacing: 1.5,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.className,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Welcome to your learning space!',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Tabs
          Container(
            color: Colors.white,
            child: TabBar(
              controller: tabController,
              labelColor: const Color(0xFF4285F4),
              unselectedLabelColor: Colors.grey,
              indicatorColor: const Color(0xFF4285F4),
              indicatorWeight: 3,
              tabs: const [
                Tab(
                  icon: Icon(Icons.dynamic_feed_rounded),
                  text: 'Stream',
                ),
                Tab(
                  icon: Icon(Icons.assignment_rounded),
                  text: 'Classwork',
                ),
              ],
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                // Stream tab
                ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0xFFDCE8FF),
                            child: Icon(
                              Icons.campaign_rounded,
                              color: Color(0xFF4285F4),
                            ),
                          ),
                          SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              'Welcome! Check this page for class updates and announcements.',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Recent activity',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...assignments.map(
                      (assignment) => Card(
                        color: Colors.white,
                        elevation: 0,
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Color(0xFFE4EDFF),
                            child: Icon(
                              Icons.assignment_outlined,
                              color: Color(0xFF4285F4),
                            ),
                          ),
                          title: Text(assignment['title']!),
                          subtitle: Text(assignment['due']!),
                        ),
                      ),
                    ),
                  ],
                ),

                // Classwork tab
                assignments.isEmpty
                    ? const Center(
                        child: Text('No classwork available yet'),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: assignments.length,
                        itemBuilder: (context, index) {
                          final assignment = assignments[index];

                          return Container(
                            margin: const EdgeInsets.only(bottom: 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              leading: const CircleAvatar(
                                backgroundColor: Color(0xFFE4EDFF),
                                child: Icon(
                                  Icons.assignment_rounded,
                                  color: Color(0xFF4285F4),
                                ),
                              ),
                              title: Text(
                                assignment['title']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  '${assignment['description']}\n${assignment['due']}',
                                ),
                              ),
                              isThreeLine: true,
                              trailing: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(assignment['title']!),
                                    content: Text(
                                      '${assignment['description']}\n\n${assignment['due']}',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context),
                                        child: const Text('Close'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
