import 'package:flutter/material.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.orange,
            tabs: [
              Tab(text: "Messages"),
              Tab(text: "Requests"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                Center(child: Text("Messages Screen")),
                Center(child: Text("Chat Requests Screen")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
