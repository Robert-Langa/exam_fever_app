import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primaryBlue,
            ),
            child: Text(
              "ExamFever",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          ListTile(
            leading: const Icon(
              Icons.home,
              color: AppColors.primaryBlue,
            ),
            title: const Text(
              "Home",
              style: TextStyle(color: AppColors.primaryBlue),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: const Icon(
              Icons.logout,
              color: AppColors.accentOrange,
            ),
            title: const Text(
              "Logout",
              style: TextStyle(color: AppColors.accentOrange),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
