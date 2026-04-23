import 'package:exam_fever_app/core/theme_controller.dart';
import 'package:flutter/material.dart';
import '../widgets/drawer_scaffold.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isDark = ThemeController.themeMode.value == ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    return DrawerScaffold(
      title: "Settings",
      role: "Student",
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text("Dark Mode", style: TextStyle(fontSize: 18)),

            Switch(
              value: isDark,
              onChanged: (value) {
                setState(() {
                  isDark = value;
                });

                ThemeController.toggleTheme(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
