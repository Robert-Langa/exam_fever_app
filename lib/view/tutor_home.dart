import 'package:exam_fever_app/view/ai_search_tab.dart';
import 'package:exam_fever_app/view/chat_tab.dart';
import 'package:exam_fever_app/view/map_tab.dart';
import 'package:exam_fever_app/widgets/drawer_scaffold.dart';
import 'package:flutter/material.dart';

class TutorHome extends StatelessWidget {
  const TutorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: DrawerScaffold(
        title: "Tutor Home",
        role: "Tutor",
        body: Column(
          children: [
            TabBar(
                indicatorColor: Colors.orange,
                labelColor: Colors.orange,
                unselectedLabelColor: Colors.black,
              tabs: [
                Tab(icon: Icon(Icons.map,  size: 30), text: "Map"),
                Tab(icon: Icon(Icons.chat,  size: 30), text: "Chat"),
                Tab(icon: Icon(Icons.search,  size: 30), text: "AI Search"),
              ],
            ),

            Expanded(
              child: TabBarView(
                children: [
                  MapTab(),
                  ChatTab(),
                  AiSearchTab(), // reused existing student screen
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
