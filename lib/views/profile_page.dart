import 'package:flutter/material.dart';
import '../widgets/drawer_scaffold.dart';

class Profile extends StatelessWidget {
  final String role;

  const Profile({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final isTutor = role == "Tutor";

    return DrawerScaffold(
      title: "Profile",
      role: role,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Color(0xFF0D47A1),
                ),
              ),
            ),

            SizedBox(height: 20),

            Text(
              "Name: ${isTutor ? "Y Tutor" : "X Student"}",
              style: TextStyle(fontSize: 18),
            ),

            SizedBox(height: 10),

            Text(
              "Email: ${isTutor ? "tutor@app.com" : "student@app.com"}",
              style: TextStyle(fontSize: 18),
            ),

            SizedBox(height: 10),

            Text(
              "Role: ${isTutor ? "Tutor" : "Student"}",
              style: TextStyle(fontSize: 18),
            ),

            SizedBox(height: 10),

            Text(
              "Age: 22",
              style: TextStyle(fontSize: 18),
            ),

            SizedBox(height: 10),

            Text(
              "Location: Canada",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
