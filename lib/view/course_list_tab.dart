import 'package:flutter/material.dart';

class CoursesTab extends StatelessWidget {
  final List<Map<String, dynamic>> courses;

  const CoursesTab({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) {
      return const Center(
        child: Text(
          "No courses added yet",
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: ListTile(
            leading: const Icon(Icons.book, color: Colors.blueAccent),
            title: Text(course['title'] ?? 'No Title'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Education: ${course['education'] ?? 'N/A'}"),
                Text("Exam: ${course['exam'] ?? 'N/A'}"),
              ],
            ),
          ),
        );
      },
    );
  }
}
