import 'package:exam_fever_app/view/ai_search_tab.dart';
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
              labelColor: Colors.orange,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.orange,
              tabs: [
                Tab(icon: Icon(Icons.map), text: "Map"),
                Tab(icon: Icon(Icons.chat), text: "Chat"),
                Tab(icon: Icon(Icons.search), text: "AI Search"),
              ],
            ),

            Expanded(
              child: TabBarView(
                children: [
                  Center(child: Text("Map Screen")),
                  Center(child: Text("Chat Screen")),
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
