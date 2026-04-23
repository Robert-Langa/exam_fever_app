import 'package:flutter/material.dart';
import '../widgets/drawer_scaffold.dart';
import '../core/app_colors.dart';

class Profile extends StatelessWidget {
  final String role;

  const Profile({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final isTutor = role == "Tutor";

    return DrawerScaffold(
      title: "Profile",
      role: role,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.white,
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: AppColors.primaryBlue,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Name: ${isTutor ? "Y Tutor" : "X Student"}",
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Email: ${isTutor ? "tutor@app.com" : "student@app.com"}",
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.primaryBlue,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Role: ${isTutor ? "Tutor" : "Student"}",
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.primaryBlue,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Age: 22",
              style: TextStyle(
                fontSize: 18,
                color: AppColors.primaryBlue,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Location: Canada",
              style: TextStyle(
                fontSize: 18,
                color: AppColors.primaryBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
