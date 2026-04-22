import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primary,
            ),
            child: Text(
              "ExamFever",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            title: const Text("Home"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("Logout"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
