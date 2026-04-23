import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  static const darkBlue = Color(0xFF0D47A1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/exam_fever_logo.png', width: 200),

            SizedBox(height: 20),

            Text(
              "Forgot your password?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 10),

            Text(
              "Please enter the email address you'd like your password reset information sent to",
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                labelText: "Email address",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: darkBlue,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {},
              child: Text("Reset password", style: TextStyle(color: Colors.white),),
            ),

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Back to login")
            ),
          ],
        ),
      ),
    );
  }
}
