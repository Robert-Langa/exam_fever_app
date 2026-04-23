import 'package:exam_fever_app/view/add_course_screen.dart';
import 'package:exam_fever_app/view/ai_search_tab.dart';
import 'package:exam_fever_app/view/ask_tutor_tab.dart';
import 'package:exam_fever_app/view/course_list_tab.dart';
import 'package:exam_fever_app/view/upload_file_tab.dart';
import 'package:exam_fever_app/widgets/drawer_scaffold.dart';
import 'package:flutter/material.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  final List<Map<String, dynamic>> courses = [];

  void goToAddCourse() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddCourseScreen()),
    );

    if (!mounted) return;

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        courses.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: DrawerScaffold(
        title: "Student Home",
        role: "Student",
        body: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              TabBar(
                indicatorColor: Colors.orange,
                labelColor: Colors.orange,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(icon: Icon(Icons.list, size: 30), text: "Courses"),
                  Tab(icon: Icon(Icons.upload_file, size: 30), text: "Upload"),
                  Tab(icon: Icon(Icons.help_outline, size: 30), text: "Ask Tutor"),
                  Tab(icon: Icon(Icons.search, size: 30), text: "AI Search"),
                ],
              ),

              Expanded(
                child: TabBarView(
                  children: [
                    CoursesTab(courses: courses),
                    UploadFileTab(),
                    AskTutorTab(),
                    AiSearchTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
