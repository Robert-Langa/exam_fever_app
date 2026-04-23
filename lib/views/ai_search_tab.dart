import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class AiSearchTab extends StatefulWidget {
  const AiSearchTab({super.key});

  @override
  State<AiSearchTab> createState() => _AiSearchTabState();
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class _AiSearchTabState extends State<AiSearchTab> {
  final TextEditingController controller = TextEditingController();

  List<ChatMessage> messages = [
    ChatMessage(
      text: "Hello! I am Sasaharo🤖. How may I help you?",
      isUser: false,
    ),
  ];

  void sendMessage() {
    if (controller.text.trim().isEmpty) return;

    String userText = controller.text;

    setState(() {
      messages.add(ChatMessage(text: userText, isUser: true));

      messages.add(ChatMessage(
        text: "Excellent. This is a very nice question.",
        isUser: false,
      ));
    });

    controller.clear();
  }

  Widget buildMessage(ChatMessage msg) {
    return Align(
      alignment:
          msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.all(12),
        constraints: BoxConstraints(maxWidth: 250),
        decoration: BoxDecoration(
          color: msg.isUser
              ? AppColors.gold
              : AppColors.primaryBlue.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          msg.text,
          style: TextStyle(
            color: msg.isUser
                ? AppColors.white
                : AppColors.primaryBlue,
            fontSize: 15,
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
                color: AppColors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: "Ask something...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: sendMessage,
                    icon: Icon(
                      Icons.send,
                      color: AppColors.accentOrange,
                    ),
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
