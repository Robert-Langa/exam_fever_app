import 'package:exam_fever_app/view/ai_search_tab.dart';
import 'package:exam_fever_app/view/ask_tutor_tab.dart';
import 'package:exam_fever_app/view/chat_tab.dart';
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

    Future.delayed(Duration(milliseconds: 200), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: Colors.orange),
        ),
        backgroundColor: Color(0xFF0D47A1),
        iconTheme: IconThemeData(color: Colors.white),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF0D47A1),
              ),
              child: Text(
                "$role Panel",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),

            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/home");
              },
            ),

            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/profile");
              },
            ),

            ListTile(
              leading: Icon(Icons.book),
              title: Text("Courses"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/courses");
              },
            ),

            ListTile(
              leading: Icon(Icons.chat),
              title: Text("Messages"),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(
                        title: Text(
                          role == "Tutor" ? "Chat" : "Ask Tutor",
                        ),
                        backgroundColor: Color(0xFF0D47A1),
                        iconTheme: IconThemeData(color: Colors.white),
                      ),
                      body: role == "Tutor"
                          ? ChatTab()
                          : AskTutorTab(),
                    ),
                  ),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.smart_toy),
              title: Text("AI Assistant"),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(
                        title: Text("AI Assistant"),
                        backgroundColor: Color(0xFF0D47A1),
                        iconTheme: IconThemeData(color: Colors.white),
                      ),
                      body: AiSearchTab(),
                    ),
                  ),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.map),
              title: Text("Map"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/map");
              },
            ),

            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/settings");
              },
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () => logout(context),
            ),
          ],
        ),
      ),

      body: body,
    );
  }
}
