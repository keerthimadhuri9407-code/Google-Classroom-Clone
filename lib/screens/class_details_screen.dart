import 'package:flutter/material.dart';

class ClassDetailsScreen extends StatelessWidget {
  final String className;

  const ClassDetailsScreen({
    super.key,
    required this.className,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(className),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Stream"),
              Tab(text: "Classwork"),
              Tab(text: "People"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _streamTab(),
            _classworkTab(),
            _peopleTab(),
          ],
        ),
      ),
    );
  }

  Widget _streamTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          height: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Colors.blueAccent, Colors.blue],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  className,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Welcome to your classroom",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.campaign,
                color: Colors.white,
              ),
            ),
            title: Text("Announcement"),
            subtitle: Text(
              "Assignment-1 uploaded. Submit before Friday.",
            ),
          ),
        ),

        Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.assignment,
                color: Colors.white,
              ),
            ),
            title: Text("New Assignment"),
            subtitle: Text(
              "DBMS ER Diagram Submission",
            ),
          ),
        ),
      ],
    );
  }

  Widget _classworkTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Card(
          child: ListTile(
            leading: Icon(Icons.assignment),
            title: Text("Assignment 1"),
            subtitle: Text("Due: Oct 10"),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.quiz),
            title: Text("Quiz 1"),
            subtitle: Text("Due: Oct 12"),
          ),
        ),
      ],
    );
  }

  Widget _peopleTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text(
          "Teacher",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        ListTile(
          leading: CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text("Faculty"),
        ),
        Divider(),
        Text(
          "Students",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        ListTile(
          leading: CircleAvatar(
            child: Icon(Icons.person_outline),
          ),
          title: Text("Student 1"),
        ),
        ListTile(
          leading: CircleAvatar(
            child: Icon(Icons.person_outline),
          ),
          title: Text("Student 2"),
        ),
      ],
    );
  }
}