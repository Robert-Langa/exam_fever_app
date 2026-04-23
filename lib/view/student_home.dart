import 'package:exam_fever_app/view/ai_search_tab.dart';
import 'package:exam_fever_app/view/ask_tutor_tab.dart';
import 'package:exam_fever_app/view/course_list_tab.dart';
import 'package:exam_fever_app/view/upload_file_tab.dart';
import 'package:exam_fever_app/widgets/drawer_scaffold.dart';
import 'package:flutter/material.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: DrawerScaffold(
        title: "Student Home",
        role: "Student",
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
    );
  }
}