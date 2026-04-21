import 'package:flutter/material.dart';
import 'upload_notes_screen.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  static const darkBlue = Color(0xFF0D47A1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Home"),
        backgroundColor: darkBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("Welcome Student 👩‍🎓", style: TextStyle(fontSize: 22)),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: darkBlue,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const UploadNotesScreen()),
                );
              },
              child: const Text("Upload Study Notes"),
            ),
          ],
        ),
      ),
    );
  }
}
