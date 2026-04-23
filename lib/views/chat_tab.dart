import 'package:flutter/material.dart';
import '../core/app_colors.dart';

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
      alignment:
          msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 260),
        decoration: BoxDecoration(
          color: msg.isUser
              ? AppColors.accentOrange
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
            padding: const EdgeInsets.all(10),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return buildMessage(messages[index]);
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 20),
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: "Type a message...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: sendMessage,
                    icon: const Icon(
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
