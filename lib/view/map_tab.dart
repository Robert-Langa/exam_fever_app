import 'package:exam_fever_app/view/active_questions_tab.dart';
import 'package:exam_fever_app/view/view_map.dart';
import 'package:flutter/material.dart';

class MapTab extends StatelessWidget {
  const MapTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.orange,
            tabs: [
              Tab(text: "View Map"),
              Tab(text: "Active Questions"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                 ViewMap(), 
                 ActiveQuestions(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}