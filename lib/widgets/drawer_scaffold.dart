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
    Navigator.pop(context); // close drawer first

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
                role,
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
              },
            ),

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
