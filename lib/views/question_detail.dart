import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class QuestionDetailScreen extends StatelessWidget {
  final String question;

  const QuestionDetailScreen({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: Text("Question Detail"),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              color: AppColors.white,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  question,
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            Text(
              "Answer",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryBlue,
              ),
            ),

            SizedBox(height: 10),

            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primaryBlue.withOpacity(0.2),
                  ),
                ),
                child: Text(
                  "This is a good question. Here is the explanation provided by the tutor or AI assistant.",
                  style: TextStyle(fontSize: 15, color: AppColors.primaryBlue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
