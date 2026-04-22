import 'package:flutter/material.dart';
import '../core/app_style.dart';
import '../core/app_colors.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        backgroundColor: AppColors.primary,
      ),

      body: Container(
        decoration: AppStyles.background(),

        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Column(
              children: [
                /// TITLE
                const Text(
                  "Create a New Account",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 25),

                /// INPUTS
                TextField(
                  controller: firstName,
                  decoration: AppStyles.input("First Name"),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: lastName,
                  decoration: AppStyles.input("Last Name"),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: email,
                  decoration: AppStyles.input("Email"),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: AppStyles.input("Password"),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: confirmPassword,
                  obscureText: true,
                  decoration: AppStyles.input("Confirm Password"),
                ),

                const SizedBox(height: 25),

                /// BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: AppStyles.primaryButton(),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Create Account"),
                  ),
                ),

                const SizedBox(height: 10),

                /// BACK
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Back to Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
