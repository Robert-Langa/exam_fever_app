import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class ActiveQuestions extends StatelessWidget {
  ActiveQuestions({super.key});

  final List<Map<String, dynamic>> questions = [
    {
      "student": "John Smith",
      "subject": "Mathematics",
      "question": "Need help with calculus",
      "time": "10 min ago",
    },
    {
      "student": "Sarah Johnson",
      "subject": "Physics",
      "question": "Struggling with quantum mechanics",
      "time": "25 min ago",
    },
    {
      "student": "Michael Brown",
      "subject": "Programming",
      "question": "Dart and Flutter help needed",
      "time": "1 hour ago",
    },
    {
      "student": "Emily Davis",
      "subject": "Chemistry",
      "question": "Organic chemistry doubts",
      "time": "2 hours ago",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final q = questions[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.help_outline, color: AppColors.primary),
            ),
            title: Text(
              q['student'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${q['subject']} • ${q['question']}"),
                Text(
                  q['time'],
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward, color: AppColors.secondary),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Responding to ${q['student']}'s question")),
              );
            },
          ),
        );
      },
    );
  }
}