import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class AskTutorTab extends StatefulWidget {
  const AskTutorTab({super.key});

  @override
  State<AskTutorTab> createState() => _AskTutorTabState();
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class _AskTutorTabState extends State<AskTutorTab> {
  final TextEditingController controller = TextEditingController();

  List<ChatMessage> messages = [
    ChatMessage(
      text: "Hello I am here to help you with the problem.",
      isUser: false,
    ),
  ];

  void sendMessage() {
    if (controller.text.trim().isEmpty) return;

    String userText = controller.text;

    setState(() {
      messages.add(ChatMessage(text: userText, isUser: true));

      messages.add(ChatMessage(
        text: "Here's how you can solve this question.",
        isUser: false,
      ));
    });

    controller.clear();
  }

  Widget buildMessage(ChatMessage msg) {
    return Align(
      alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 260),
        decoration: BoxDecoration(
          color: msg.isUser
              ? AppColors.gold
              : AppColors.primaryBlue.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          msg.text,
          style: TextStyle(
            color: msg.isUser ? AppColors.white : AppColors.primaryBlue,
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
                        hintText: "Ask your tutor...",
                        
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
