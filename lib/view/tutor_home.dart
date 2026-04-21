import 'package:flutter/material.dart';

class TutorHome extends StatelessWidget {
  const TutorHome({super.key});

  static const darkBlue = Color(0xFF0D47A1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tutor Home"),
        backgroundColor: darkBlue,
      ),
      body: const Center(
        child: Text(
          "Welcome Tutor 👨‍🏫\nManage students & sessions here",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
