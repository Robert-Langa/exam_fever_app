import 'package:exam_fever_app/view/add_course_screen.dart';
import 'package:exam_fever_app/view/course_details.dart';
import 'package:flutter/material.dart';
import 'package:exam_fever_app/database/db_helper.dart';

class CoursesTab extends StatefulWidget {
  const CoursesTab({super.key});

  @override
  State<CoursesTab> createState() => _CoursesTabState();
}

class _CoursesTabState extends State<CoursesTab> {
  List<Map<String, dynamic>> courses = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCourses();
  }

  Future<void> loadCourses() async {
    setState(() {
      isLoading = true;
    });
    
    List<Map<String, dynamic>> courseList = await DBHelper().getAllCourses();
    
    setState(() {
      courses = courseList;
      isLoading = false;
    });
  }

  void goToAddCourse() async {
    bool? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddCourseScreen()),
    );
    
    if (result == true) {
      loadCourses();
    }
  }

  void editCourse(Map<String, dynamic> course) async {
    bool? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCourseScreen(
          existingCourse: course,
          courseId: course['id'],
        ),
      ),
    );
    
    if (result == true) {
      loadCourses();
    }
  }

  void deleteCourse(int id, String name) async {
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Deletion"),
        content: Text("Are you sure you want to delete '$name'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      int result = await DBHelper().deleteCourse(id);
      if (result > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Course deleted successfully")),
        );
        loadCourses();
      }
    }
  }

  void openCourseDetail(Map<String, dynamic> course) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CourseDetailScreen(course: course),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        isLoading
            ? Center(child: CircularProgressIndicator())
            : courses.isEmpty
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
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: ListTile(
                          leading: Icon(Icons.book, color: Colors.blueAccent),
                          title: Text(course['name'] ?? 'No Title'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Education: ${course['education'] ?? 'N/A'}"),
                              Text("Exam Format: ${course['format'] ?? 'N/A'}"),
                              Text("Exam Date: ${course['examDate'] ?? 'N/A'}"),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.orange),
                                onPressed: () => editCourse(course),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => deleteCourse(course['id'], course['name']),
                              ),
                            ],
                          ),
                          onTap: () => openCourseDetail(course),
                        ),
                      );
                    },
                  ),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            onPressed: goToAddCourse,
            backgroundColor: Colors.orange,
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}