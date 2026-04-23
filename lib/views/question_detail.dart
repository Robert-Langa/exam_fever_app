import 'package:flutter/material.dart';

class QuestionDetailScreen extends StatelessWidget {
  final String question;

  const QuestionDetailScreen({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Question Detail"),
        backgroundColor: Color(0xFF0D47A1),
        iconTheme: IconThemeData(color: Colors.white),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  question,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            SizedBox(height: 20),

            Text(
              "Answer",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "This is a good question. Here is the explanation provided by the tutor or AI assistant.",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
