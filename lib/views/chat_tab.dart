import 'package:flutter/material.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({super.key});

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class _ChatTabState extends State<ChatTab> {
  final TextEditingController controller = TextEditingController();

  List<ChatMessage> messages = [
    ChatMessage(
      text: "Hello Tutor, I need your help. How to learn DSA in 5 Minutes",
      isUser: false,
    ),
  ];

  void sendMessage() {
    if (controller.text.trim().isEmpty) return;

    String userText = controller.text;

    setState(() {
      messages.add(ChatMessage(text: userText, isUser: true));

      messages.add(ChatMessage(
        text: "Thank you.",
        isUser: false,
      ));
    });

    controller.clear();
  }

  Widget buildMessage(ChatMessage msg) {
    return Align(
      alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.all(12),
        constraints: BoxConstraints(maxWidth: 260),
        decoration: BoxDecoration(
          color: msg.isUser ? Colors.orange : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          msg.text,
          style: TextStyle(
            color: msg.isUser ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return buildMessage(messages[index]);
            },
          ),
        ),

        Padding(
          padding: EdgeInsets.fromLTRB(12, 10, 12, 20),
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: sendMessage,
                    icon: Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
