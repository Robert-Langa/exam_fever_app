import 'package:exam_fever_app/view/add_course_screen.dart';
import 'package:flutter/material.dart';

class CoursesTab extends StatelessWidget {
  final List<Map<String, dynamic>> courses;

  const CoursesTab({super.key, required this.courses});

  void goToAddCourse(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCourseScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        courses.isEmpty
            ? Center(
                child: Text(
                  "No courses added yet",
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];

                  return Card(
                    margin: EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    child: ListTile(
                      leading: Icon(Icons.book, color: Colors.blueAccent),
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
              ),

        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            onPressed: () => goToAddCourse(context),
            backgroundColor: Colors.orange,
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
