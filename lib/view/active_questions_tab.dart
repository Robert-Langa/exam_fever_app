import 'package:flutter/material.dart';

class ActiveQuestions extends StatelessWidget {
  const ActiveQuestions({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> questions = [
      "Math question pending",
      "Physics help needed",
      "Assignment review request",
      "Exam doubt clarification",
    ];

    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: questions.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: Icon(Icons.help_outline, color: Colors.orange),
            title: Text(questions[index]),
            subtitle: Text("Tap to view details"),
          ),
        );
      },
    );
  }
}
