import 'package:exam_fever_app/view/exam_screen.dart';
import 'package:flutter/material.dart';

class CourseDetailScreen extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF0D47A1);
    const accent = Colors.orange;

    return Scaffold(
      appBar: AppBar(
        title: Text(course['name'] ?? "Course Detail"),
        backgroundColor: primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  course['name'] ?? "No Name",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: primary,
                  ),
                ),

                SizedBox(height: 15),

                Text(
                  "Education: ${course['education'] ?? 'N/A'}",
                  style: TextStyle(fontSize: 16),
                ),

                SizedBox(height: 8),

                Text(
                  "Exam Format: ${course['format'] ?? 'N/A'}",
                  style: TextStyle(fontSize: 16),
                ),

                SizedBox(height: 8),

                Text(
                  "Difficulty Level: ${course['level'] ?? 'N/A'}",
                  style: TextStyle(fontSize: 16),
                ),

                SizedBox(height: 8),

                Text(
                  "Exam Date: ${course['date'] ?? 'N/A'}",
                  style: TextStyle(fontSize: 16),
                ),

                SizedBox(height: 8),

                Text(
                  "Address: ${course['address'] ?? 'N/A'}",
                  style: TextStyle(fontSize: 16),
                ),

                SizedBox(height: 8),

                Text(
                  "Include Answers: ${course['includeAnswers'] == true ? "Yes" : "No"}",
                  style: TextStyle(fontSize: 16),
                ),

                Spacer(),

                Row(
                  children: [

                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accent,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExamScreen(
                                courseName: course['name'] ?? "Course",
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "Start Exam",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),

                    SizedBox(width: 10),

                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
