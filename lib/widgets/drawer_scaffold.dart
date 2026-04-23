import 'package:exam_fever_app/views/ai_search_tab.dart';
import 'package:exam_fever_app/views/ask_tutor_tab.dart';
import 'package:exam_fever_app/views/chat_tab.dart';
import 'package:exam_fever_app/views/profile_page.dart';
import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class DrawerScaffold extends StatelessWidget {
  final String title;
  final String role;
  final Widget body;

  DrawerScaffold({
    super.key,
    required this.title,
    required this.role,
    required this.body,
  });

  void logout(BuildContext context) {
    Navigator.pop(context);

    Future.delayed(const Duration(milliseconds: 200), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  void goHome(BuildContext context) {
    Navigator.pop(context);

    Navigator.pushNamedAndRemoveUntil(
      context,
      role == "Tutor" ? "/tutor" : "/student",
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(color: AppColors.accentOrange),
        ),
        backgroundColor: AppColors.primaryBlue,
        iconTheme: const IconThemeData(color: AppColors.white),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: AppColors.primaryBlue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 38,
                    backgroundColor: AppColors.white,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "$role Panel",
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
              onTap: () => goHome(context),
            ),

            ListTile(
              leading: const Icon(
                Icons.person,
                color: AppColors.primaryBlue,
              ),
              title: const Text(
                "Profile",
                style: TextStyle(color: AppColors.primaryBlue),
              ),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile(role: role),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(
                Icons.chat,
                color: AppColors.primaryBlue,
              ),
              title: const Text(
                "Messages",
                style: TextStyle(color: AppColors.primaryBlue),
              ),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(
                        title: Text(
                          role == "Tutor" ? "Chat" : "Ask Tutor",
                          style: const TextStyle(
                            color: AppColors.accentOrange,
                          ),
                        ),
                        backgroundColor: AppColors.primaryBlue,
                        iconTheme: const IconThemeData(
                          color: AppColors.white,
                        ),
                      ),
                      body: role == "Tutor" ? ChatTab() : AskTutorTab(),
                    ),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(
                Icons.smart_toy,
                color: AppColors.primaryBlue,
              ),
              title: const Text(
                "AI Assistant",
                style: TextStyle(color: AppColors.primaryBlue),
              ),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(
                        title: const Text(
                          "AI Assistant",
                          style: TextStyle(
                            color: AppColors.accentOrange,
                          ),
                        ),
                        backgroundColor: AppColors.primaryBlue,
                        iconTheme: const IconThemeData(
                          color: AppColors.white,
                        ),
                      ),
                      body: AiSearchTab(),
                    ),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(
                Icons.settings,
                color: AppColors.primaryBlue,
              ),
              title: const Text(
                "Settings",
                style: TextStyle(color: AppColors.primaryBlue),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/settings");
              },
            ),

            const Divider(),

            ListTile(
              leading: const Icon(
                Icons.logout,
                color: AppColors.accentOrange,
              ),
              title: const Text(
                "Logout",
                style: TextStyle(color: AppColors.accentOrange),
              ),
              onTap: () => logout(context),
            ),
          ],
        ),
      ),

      body: body,
    );
  }
}
