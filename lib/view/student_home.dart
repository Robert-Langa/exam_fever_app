import 'package:flutter/material.dart';
import '../core/app_style.dart';
import 'upload_notes_screen.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Dashboard"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      extendBodyBehindAppBar: true,

      body: Container(
        decoration: AppStyles.background(),

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,

                    children: [
                      _card(Icons.upload_file, "Upload Notes", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const UploadNotesScreen(),
                          ),
                        );
                      }),

                      _card(Icons.menu_book, "Courses", () {}),
                      _card(Icons.search, "Search", () {}),
                      _card(Icons.map, "Map", () {}),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _card(IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,

      child: Container(
        decoration: AppStyles.glassCard(),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
