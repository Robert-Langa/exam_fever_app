import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/exam_fever_logo.png', width: 200),

            const SizedBox(height: 20),

            const Text(
              "Forgot your password?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryBlue,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 10),

            const Text(
              "Please enter the email address you'd like your password reset information sent to",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryBlue,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                labelText: "Email address",
                prefixIcon: const Icon(
                  Icons.email,
                  color: AppColors.primaryBlue,
                ),
                labelStyle: const TextStyle(
                  color: AppColors.primaryBlue,
                ),
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.accentOrange,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentOrange,
                foregroundColor: AppColors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {},
              child: const Text("Reset password"),
            ),

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Back to login",
                style: TextStyle(
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
