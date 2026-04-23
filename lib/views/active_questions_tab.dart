import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class ActiveQuestions extends StatelessWidget {
  final Function(String, String) onChatTap;

  const ActiveQuestions({super.key, required this.onChatTap});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> questions = [
      {
        "name": "John Smith",
        "subject": "Mathematics",
        "question": "Need help with calculus",
        "distance": "0.5 km",
      },
      {
        "name": "Sarah Johnson",
        "subject": "Physics",
        "question": "Struggling with quantum mechanics",
        "distance": "1.2 km",
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final q = questions[index];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            leading: Icon(Icons.person, color: AppColors.primary),
            title: Text(q['name']),
            subtitle: Text(q['question']),
            trailing: IconButton(
              icon: Icon(Icons.chat, color: AppColors.secondary),
              onPressed: () {
                onChatTap(q['name'], q['question']);
              },
            ),
          ),
        );
      },
    );
  }
}
