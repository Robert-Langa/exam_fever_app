import 'package:exam_fever_app/views/ai_search_tab.dart';
import 'package:exam_fever_app/views/ask_tutor_tab.dart';
import 'package:exam_fever_app/views/chat_tab.dart';
import 'package:exam_fever_app/views/profile_page.dart';
import 'package:flutter/material.dart';


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

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;

    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.orange)),
        backgroundColor: const Color(0xFF0D47A1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [

            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF0D47A1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 38,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Color(0xFF0D47A1),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "$role Panel",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: Text("Home", style: TextStyle(color: textColor)),
              onTap: () {
                Navigator.pop(context);

                if (role == "Tutor") {
                  Navigator.pushNamed(context, "/tutor");
                } else {
                  Navigator.pushNamed(context, "/student");
                }
              },
            ),

            ListTile(
              leading: const Icon(Icons.person),
              title: Text("Profile", style: TextStyle(color: textColor)),
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
              leading: const Icon(Icons.chat),
              title: Text("Messages", style: TextStyle(color: textColor)),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(
                        title: Text(role == "Tutor" ? "Chat" : "Ask Tutor"),
                        backgroundColor: const Color(0xFF0D47A1),
                        iconTheme: const IconThemeData(color: Colors.white),
                      ),
                      body: role == "Tutor" ? ChatTab() : AskTutorTab(),
                    ),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.smart_toy),
              title: Text("AI Assistant", style: TextStyle(color: textColor)),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(
                        title: const Text("AI Assistant"),
                        backgroundColor: const Color(0xFF0D47A1),
                        iconTheme: const IconThemeData(color: Colors.white),
                      ),
                      body: AiSearchTab(),
                    ),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.map),
              title: Text("Map", style: TextStyle(color: textColor)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/viewmap");
              },
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: Text("Settings", style: TextStyle(color: textColor)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/settings");
              },
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout),
              title: Text("Logout", style: TextStyle(color: textColor)),
              onTap: () => logout(context),
            ),
          ],
        ),
      ),

      body: body,
    );
  }
}
