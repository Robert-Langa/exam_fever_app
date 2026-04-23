import 'package:flutter/material.dart';
import 'exam_screen.dart';

class CourseDetailScreen extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course['name'] ?? "Course Detail"),
        backgroundColor: const Color(0xFF0D47A1),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Card(
                elevation: 4,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course['name'] ?? "",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),

                        Text("Education: ${course['education']}"),
                        const SizedBox(height: 8),

                        Text("Format: ${course['format']}"),
                        const SizedBox(height: 8),

                        Text("Level: ${course['level']}"),
                        const SizedBox(height: 8),

                        Text("Exam Date: ${course['examDate']}"),
                        const SizedBox(height: 8),

                        Text("Address: ${course['address']}"),
                        const SizedBox(height: 8),

                        Text(
                          "Include Answers: ${course['includeAnswers'] == 1 ? "Yes" : "No"}",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D47A1),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ExamScreen(
                            courseName: course['name'],
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Start",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Back"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
