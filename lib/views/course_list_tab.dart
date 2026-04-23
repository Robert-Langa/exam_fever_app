import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import 'add_course_screen.dart';
import 'course_details.dart';
import 'edit_course_screen.dart';
import 'exam_screen.dart';

class CoursesTab extends StatefulWidget {
  const CoursesTab({super.key});

  @override
  State<CoursesTab> createState() => _CoursesTabState();
}

class _CoursesTabState extends State<CoursesTab> {
  List<Map<String, dynamic>> courses = [];

  @override
  void initState() {
    super.initState();
    loadCourses();
  }

  Future<void> loadCourses() async {
    final data = await DBHelper().getAllCourses();
    setState(() {
      courses = data;
    });
  }

  Future<void> addCourse() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddCourseScreen()),
    );

    if (result != null) {
      await DBHelper().insertCourse(result);
      loadCourses();
    }
  }

  Future<void> editCourse(Map<String, dynamic> course) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditCourseScreen(course: course),
      ),
    );

    if (result != null) {
      await DBHelper().updateCourse(course['id'], result);
      loadCourses();
    }
  }

  Future<void> deleteCourse(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Course"),
        content: const Text("Are you sure you want to delete this course?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await DBHelper().deleteCourse(id);
      loadCourses();
    }
  }

  void openCourse(Map<String, dynamic> course) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CourseDetailScreen(course: course),
      ),
    );
  }

  void startExam(Map<String, dynamic> course) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ExamScreen(courseName: course['name']),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        courses.isEmpty
            ? const Center(child: Text("No courses added yet"))
            : ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    child: ListTile(
                      leading:
                          const Icon(Icons.book, color: Colors.blueAccent),

                      title: Text(course['name'] ?? ''),

                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Education: ${course['education']}"),
                          Text("Format: ${course['format']}"),
                        ],
                      ),

                      onTap: () => openCourse(course),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.play_arrow,
                                color: Colors.green),
                            onPressed: () => startExam(course),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit,
                                color: Colors.orange),
                            onPressed: () => editCourse(course),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.red),
                            onPressed: () => deleteCourse(course['id']),
                          ),
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
            backgroundColor: Colors.orange,
            onPressed: addCourse,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
