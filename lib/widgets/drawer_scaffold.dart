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
        title: Text(title, style: TextStyle(color: AppColors.accentOrange)),
        backgroundColor: AppColors.primaryBlue,
        iconTheme: IconThemeData(color: AppColors.white),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: AppColors.primaryBlue),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 38,
                    backgroundColor: AppColors.white,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "$role Panel",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: Icon(Icons.home, color: AppColors.primaryBlue),
              title: Text(
                "Home",
                style: TextStyle(color: AppColors.primaryBlue),
              ),
              onTap: () => goHome(context),
            ),

            ListTile(
              leading: Icon(Icons.person, color: AppColors.primaryBlue),
              title: Text(
                "Profile",
                style: TextStyle(color: AppColors.primaryBlue),
              ),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile(role: role)),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.chat, color: AppColors.primaryBlue),
              title: Text(
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
                          style: TextStyle(color: AppColors.accentOrange),
                        ),
                        backgroundColor: AppColors.primaryBlue,
                        iconTheme: IconThemeData(color: AppColors.white),
                      ),
                      body: role == "Tutor" ? ChatTab() : AskTutorTab(),
                    ),
                  ),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.smart_toy, color: AppColors.primaryBlue),
              title: Text(
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
                        title: Text(
                          "AI Assistant",
                          style: TextStyle(color: AppColors.accentOrange),
                        ),
                        backgroundColor: AppColors.primaryBlue,
                        iconTheme: IconThemeData(color: AppColors.white),
                      ),
                      body: AiSearchTab(),
                    ),
                  ),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.settings, color: AppColors.primaryBlue),
              title: Text(
                "Settings",
                style: TextStyle(color: AppColors.primaryBlue),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/settings");
              },
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.logout, color: AppColors.accentOrange),
              title: Text(
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
