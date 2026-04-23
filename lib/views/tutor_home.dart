import 'package:exam_fever_app/views/ai_search_tab.dart';
import 'package:exam_fever_app/views/chat_tab.dart';
import 'package:exam_fever_app/views/map_tab.dart';
import 'package:exam_fever_app/widgets/drawer_scaffold.dart';
import 'package:flutter/material.dart';

class TutorHome extends StatelessWidget {
  const TutorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Builder(
        builder: (context) {
          final primary = Theme.of(context).colorScheme.primary;
          final unselected =
              Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;

          void goToChat() {
            DefaultTabController.of(context).animateTo(1);
          }

          return DrawerScaffold(
            title: "Tutor Home",
            role: "Tutor",
            body: Column(
              children: [
                TabBar(
                  indicatorColor: primary,
                  labelColor: primary,
                  unselectedLabelColor: unselected,
                  tabs: const [
                    Tab(icon: Icon(Icons.map, size: 30), text: "Map"),
                    Tab(icon: Icon(Icons.chat, size: 30), text: "Chat"),
                    Tab(icon: Icon(Icons.search, size: 30), text: "AI Search"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      MapTab(onChatTap: goToChat),
                      const ChatTab(),
                      const AiSearchTab(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
