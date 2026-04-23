import 'package:exam_fever_app/views/active_questions_tab.dart';
import 'package:flutter/material.dart';
import 'view_map.dart';

class MapTab extends StatelessWidget {
  final VoidCallback? onChatTap;

  const MapTab({super.key, this.onChatTap});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            indicatorColor: Colors.orange,
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.black,
            tabs: const [
              Tab(text: "View Map", icon: Icon(Icons.map)),
              Tab(text: "Active Questions", icon: Icon(Icons.list)),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                ViewMap(onMarkerTap: onChatTap!), 
                ActiveQuestions(
                  onChatTap: (a, b) {
                    if (onChatTap != null) onChatTap!();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
