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
          color: AppColors.white,
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            leading: const Icon(
              Icons.person,
              color: AppColors.primaryBlue,
            ),
            title: Text(
              q['name'],
              style: const TextStyle(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              q['question'],
              style: const TextStyle(
                color: Colors.black87,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.chat,
                color: AppColors.accentOrange,
              ),
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
