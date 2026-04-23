import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/exam_fever_logo.png', width: 200),

            SizedBox(height: 20),

            Text(
              "Forgot your password?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryBlue,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 10),

            Text(
              "Please enter the email address you'd like your password reset information sent to",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryBlue,
              ),
            ),

            SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                labelText: "Email address",
                prefixIcon: Icon(
                  Icons.email,
                  color: AppColors.primaryBlue,
                ),
                labelStyle: TextStyle(
                  color: AppColors.primaryBlue,
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.accentOrange,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentOrange,
                foregroundColor: AppColors.white,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {},
              child: Text("Reset password"),
            ),

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
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
