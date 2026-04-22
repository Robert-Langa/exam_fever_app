import 'package:flutter/material.dart';
import '../core/app_style.dart';
import '../core/app_colors.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
        backgroundColor: AppColors.primary,
      ),

      body: Container(
        decoration: AppStyles.background(),

        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: AppStyles.glassCard(),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// TITLE
                  const Text(
                    "Forgot Your Password?",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Please enter the email address you'd like your password reset information sent to",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),

                  const SizedBox(height: 30),

                  /// EMAIL FIELD
                  TextField(
                    controller: email,
                    decoration: AppStyles.input("Email Address"),
                  ),

                  const SizedBox(height: 25),

                  /// RESET BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: AppStyles.primaryButton(),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Send Reset Link"),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// BACK BUTTON
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Back to Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
