import 'package:flutter/material.dart';
import 'class_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final classes = [
      {
        "name": "Data Structures",
        "section": "IT-A",
      },
      {
        "name": "DBMS",
        "section": "IT-A",
      },
      {
        "name": "Operating Systems",
        "section": "IT-A",
      },
      {
        "name": "Software Engineering",
        "section": "IT-A",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: Drawer(
  child: ListView(
    children: const [
      DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Text(
          "Google Classroom",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      ListTile(
        leading: Icon(Icons.class_),
        title: Text("Classes"),
      ),
      ListTile(
        leading: Icon(Icons.assignment),
        title: Text("Assignments"),
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text("Settings"),
      ),
    ],
  ),
),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Google Classroom",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
  Icon(Icons.notifications_none),
  SizedBox(width: 10),
  Padding(
    padding: EdgeInsets.only(right: 15),
    child: CircleAvatar(
      child: Icon(Icons.person),
    ),
  ),
],
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: classes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ClassDetailsScreen(
                    className: classes[index]["name"]!,
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 15),
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Colors.blueAccent,
                    Colors.blue,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      classes[index]["name"]!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      classes[index]["section"]!,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),

                    const Spacer(),

                    const Row(
                      mainAxisAlignment:
                          MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.folder_open,
                          color: Colors.white,
                        ),
                        SizedBox(width: 15),
                        Icon(
                          Icons.assignment,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),

      floatingActionButton:
          FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        onPressed: () {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Join Class"),
        content: const TextField(
          decoration: InputDecoration(
            hintText: "Enter Class Code",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Join"),
          ),
        ],
      );
    },
  );
},
        icon: const Icon(Icons.add),
        label: const Text("Join Class"),
      ),
    );
  }
}