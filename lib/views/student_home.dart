import 'package:exam_fever_app/views/ai_search_tab.dart';
import 'package:exam_fever_app/views/ask_tutor_tab.dart';
import 'package:exam_fever_app/views/course_list_tab.dart';
import 'package:exam_fever_app/views/upload_file_tab.dart';
import 'package:exam_fever_app/widgets/drawer_scaffold.dart';
import 'package:flutter/material.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final unselected =
        Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;

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
                indicatorColor: primary,
                labelColor: primary,
                unselectedLabelColor: unselected,
                tabs: const [
                  Tab(icon: Icon(Icons.list, size: 30), text: "Courses"),
                  Tab(icon: Icon(Icons.upload_file, size: 30), text: "Upload"),
                  Tab(icon: Icon(Icons.help_outline, size: 30), text: "Ask Tutor"),
                  Tab(icon: Icon(Icons.search, size: 30), text: "AI Search"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: const [
                    CoursesTab(),
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
