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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assignments"),
      ),
      body: ListView(
        children: const [
          Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(Icons.assignment),
              title: Text("DBMS Assignment"),
              subtitle: Text("Due Tomorrow"),
            ),
          ),
          Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(Icons.quiz),
              title: Text("OS Quiz"),
              subtitle: Text("Due Friday"),
            ),
          ),
        ],
      ),
    );
  }
}