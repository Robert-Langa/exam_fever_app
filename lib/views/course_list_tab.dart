import 'package:exam_fever_app/views/add_course_screen.dart';
import 'package:exam_fever_app/views/course_details.dart';
import 'package:flutter/material.dart';

class CoursesTab extends StatelessWidget {
  final List<Map<String, dynamic>> courses;

  const CoursesTab({super.key, required this.courses});

  List<Map<String, dynamic>> get displayCourses {
    if (courses.isNotEmpty) return courses;

    return [
      {
        "title": "Mathematics",
        "education": "Grade 12",
        "exam": "Theory",
      },
      {
        "title": "Physics",
        "education": "Grade 11",
        "exam": "Objective",
      },
    ];
  }

  void goToAddCourse(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCourseScreen(),
      ),
    );
  }

  void openCourseDetail(BuildContext context, Map<String, dynamic> course) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CourseDetailScreen(course: course),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = displayCourses;

    return Stack(
      children: [
        list.isEmpty
            ? Center(
                child: Text(
                  "No courses added yet",
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final course = list[index];

                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.orange),
                            onPressed: () {},
                          ),

                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {},
                          ),
                        ],
                      ),

                      onTap: () => openCourseDetail(context, course),
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
