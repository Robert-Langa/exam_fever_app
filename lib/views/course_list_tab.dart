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
    setState(() => courses = data);
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
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: courses.isEmpty
          ? const Center(
              child: Text(
                "No courses added yet",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: InkWell(
                    onTap: () => openCourse(course),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.book,
                                        color: Colors.deepOrange, size: 28),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        course['name'] ?? '',
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.school,
                                        size: 18, color: Colors.blue),
                                    const SizedBox(width: 6),
                                    Text(
                                      "Education: ${course['education'] ?? ''}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(Icons.list_alt,
                                        size: 18, color: Colors.purple),
                                    const SizedBox(width: 6),
                                    Text(
                                      "Format: ${course['format'] ?? ''}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.purple,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
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
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: addCourse,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
