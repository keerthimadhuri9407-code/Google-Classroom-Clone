// import 'package:flutter/material.dart';
// import 'class_details_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   // const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final classes = [
//       {
//         "name": "Data Structures",
//         "section": "IT-A",
//       },
//       {
//         "name": "DBMS",
//         "section": "IT-A",
//       },
//       {
//         "name": "Operating Systems",
//         "section": "IT-A",
//       },
//       {
//         "name": "Software Engineering",
//         "section": "IT-A",
//       },
//     ];

//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       drawer: Drawer(
//   child: ListView(
//     children: const [
//       DrawerHeader(
//         decoration: BoxDecoration(
//           color: Colors.blue,
//         ),
//         child: Text(
//           "Google Classroom",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 24,
//           ),
//         ),
//       ),
//       ListTile(
//         leading: Icon(Icons.class_),
//         title: Text("Classes"),
//       ),
//       ListTile(
//         leading: Icon(Icons.assignment),
//         title: Text("Assignments"),
//       ),
//       ListTile(
//         leading: Icon(Icons.settings),
//         title: Text("Settings"),
//       ),
//     ],
//   ),
// ),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           "Google Classroom",
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: const [
//   Icon(Icons.notifications_none),
//   SizedBox(width: 10),
//   Padding(
//     padding: EdgeInsets.only(right: 15),
//     child: CircleAvatar(
//       child: Icon(Icons.person),
//     ),
//   ),
// ],
//       ),

//       body: ListView.builder(
//         padding: const EdgeInsets.all(12),
//         itemCount: classes.length,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => ClassDetailsScreen(
//                     className: classes[index]["name"]!,
//                   ),
//                 ),
//               );
//             },
//             child: Container(
//               margin: const EdgeInsets.only(bottom: 15),
//               height: 170,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 gradient: const LinearGradient(
//                   colors: [
//                     Colors.blueAccent,
//                     Colors.blue,
//                   ],
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(18),
//                 child: Column(
//                   crossAxisAlignment:
//                       CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       classes[index]["name"]!,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),

//                     const SizedBox(height: 8),

//                     Text(
//                       classes[index]["section"]!,
//                       style: const TextStyle(
//                         color: Colors.white70,
//                         fontSize: 16,
//                       ),
//                     ),

//                     const Spacer(),

//                     const Row(
//                       mainAxisAlignment:
//                           MainAxisAlignment.end,
//                       children: [
//                         Icon(
//                           Icons.folder_open,
//                           color: Colors.white,
//                         ),
//                         SizedBox(width: 15),
//                         Icon(
//                           Icons.assignment,
//                           color: Colors.white,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),

//       floatingActionButton:
//           FloatingActionButton.extended(
//         backgroundColor: Colors.blue,
//         onPressed: () {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: const Text("Join Class"),
//         content: const TextField(
//           decoration: InputDecoration(
//             hintText: "Enter Class Code",
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: const Text("Cancel"),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: const Text("Join"),
//           ),
//         ],
//       );
//     },
//   );
// },
//         icon: const Icon(Icons.add),
//         label: const Text("Join Class"),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'class_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController =
      TextEditingController();

  final TextEditingController codeController =
      TextEditingController();

  final List<Map<String, String>> classes = [];

  final List<Color> cardColors = const [
    Color(0xFF4285F4),
    Color(0xFF00897B),
    Color(0xFF8E63CE),
    Color(0xFFE58B36),
  ];

  List<Map<String, String>> get filteredClasses {
    final query = searchController.text.toLowerCase();

    return classes.where((item) {
      return item['name']!.toLowerCase().contains(query);
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    codeController.dispose();
    super.dispose();
  }
  
Future<void> joinClass(String code, BuildContext dialogContext) async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please log in first')),
    );
    return;
  }

  try {
    final result = await FirebaseFirestore.instance
        .collection('classes')
        .where('code', isEqualTo: code)
        .limit(1)
        .get();

    if (result.docs.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid class code')),
      );
      return;
    }

    final classDoc = result.docs.first;
    final data = classDoc.data();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('joinedClasses')
        .doc(classDoc.id)
        .set({
      'classId': classDoc.id,
      'name': data['name'] ?? '',
      'section': data['section'] ?? '',
      'joinedAt': FieldValue.serverTimestamp(),
    });

    if (!mounted) return;

    setState(() {
      if (!classes.any((c) => c['id'] == classDoc.id)) {
        classes.add({
          'id': classDoc.id,
          'name': data['name'] ?? '',
          'section': data['section'] ?? '',
        });
      }
    });

    Navigator.pop(dialogContext);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Joined ${data['name']} successfully!'),
      ),
    );
  } catch (e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Could not join class: $e')),
    );
  }
}

  void showJoinClassDialog() {
    codeController.clear();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: const Text(
            'Join a class',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter the class code provided by your teacher.',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: codeController,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  labelText: 'Class code',
                  hintText: 'Enter your code',
                  prefixIcon: const Icon(Icons.key_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              
onPressed: () async {
  final code = codeController.text.trim().toUpperCase();

  if (code.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please enter a class code'),
      ),
    );
    return;
  }

  await joinClass(code, dialogContext);
},

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4285F4),
                foregroundColor: Colors.white,
              ),
              child: const Text('Join class'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final visibleClasses = filteredClasses;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7FB),
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Row(
          children: [
            Icon(
              Icons.school_rounded,
              color: Color(0xFF4285F4),
              size: 30,
            ),
            SizedBox(width: 10),
            Text(
              'Classroom',
              style: TextStyle(
                color: Color(0xFF202124),
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: const Color(0xFFDCE8FF),
              child: const Icon(
                Icons.person_rounded,
                color: Color(0xFF2458A6),
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your classes',
                    style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF202124),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Everything you need to learn in one place.',
                    style: TextStyle(
                      color: Color(0xFF70757A),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 22),

                  TextField(
                    controller: searchController,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Search your classes',
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: Color(0xFF4285F4),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: visibleClasses.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(28),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 130,
                              width: 130,
                              decoration: const BoxDecoration(
                                color: Color(0xFFE4EDFF),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.menu_book_rounded,
                                size: 65,
                                color: Color(0xFF4285F4),
                              ),
                            ),
                            const SizedBox(height: 25),
                            Text(
                              searchController.text.isEmpty
                                  ? 'No classes available'
                                  : 'No classes found',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF202124),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              searchController.text.isEmpty
                                  ? 'Join a class with the code provided by your teacher.'
                                  : 'Try searching with a different class name.',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF70757A),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 24),
                            if (searchController.text.isEmpty)
                              ElevatedButton.icon(
                                onPressed: showJoinClassDialog,
                                icon: const Icon(Icons.add_rounded),
                                label: const Text('Join your first class'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(0xFF4285F4),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 22,
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 90),
                      itemCount: visibleClasses.length,
                      itemBuilder: (context, index) {
                        final classroom = visibleClasses[index];
                        final color =
                            cardColors[index % cardColors.length];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(
                                  alpha: 0.045,
                                ),
                                blurRadius: 14,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(22),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ClassDetailsScreen(
                                    className: classroom['name']!,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 125,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: color,
                                    borderRadius:
                                        const BorderRadius.vertical(
                                      top: Radius.circular(22),
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Icon(
                                          Icons.school_rounded,
                                          size: 85,
                                          color: Colors.white.withValues(
                                            alpha: 0.18,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            classroom['name']!,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 23,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            classroom['section']!,
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 15,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        tooltip: 'Open class',
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  ClassDetailsScreen(
                                                className:
                                                    classroom['name']!,
                                              ),
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.arrow_forward_rounded,
                                          color: Color(0xFF4285F4),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: showJoinClassDialog,
        backgroundColor: const Color(0xFF4285F4),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Join class'),
      ),
    );
  }
}
