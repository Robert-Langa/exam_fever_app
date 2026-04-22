import 'package:flutter/material.dart';
import '../core/app_style.dart';
import 'student_home.dart';
import 'tutor_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppStyles.background(),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              const Text(
                "Select Role",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 30),

              /// STUDENT BUTTON
              ElevatedButton(
                style: AppStyles.primaryButton(),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const StudentHome()),
                  );
                },
                child: const Text("Student"),
              ),

              const SizedBox(height: 15),

              /// TUTOR BUTTON
              ElevatedButton(
                style: AppStyles.primaryButton(),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TutorHome()),
                  );
                },
                child: const Text("Tutor"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
