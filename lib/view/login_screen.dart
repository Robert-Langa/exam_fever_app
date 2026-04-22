import 'package:flutter/material.dart';
import '../core/app_style.dart';
import 'home_page.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppStyles.background(),

        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// LOGO
                Image.asset('assets/images/exam_fever_logo.png', width: 180),

                const SizedBox(height: 40),

                /// EMAIL
                TextField(
                  controller: emailController,
                  decoration: AppStyles.input("Email"),
                ),

                const SizedBox(height: 12),

                /// PASSWORD
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: AppStyles.input("Password"),
                ),

                const SizedBox(height: 25),

                /// LOGIN BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: AppStyles.primaryButton(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
                      );
                    },
                    child: const Text("Login"),
                  ),
                ),

                const SizedBox(height: 10),

                /// SIGN UP
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SignupScreen()),
                    );
                  },
                  child: const Text("Sign Up"),
                ),

                /// FORGOT PASSWORD
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ForgotPasswordScreen()),
                    );
                  },
                  child: const Text("Forgot Password?"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
