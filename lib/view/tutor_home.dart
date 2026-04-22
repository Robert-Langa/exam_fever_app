import 'package:exam_fever_app/widgets/drawer_scaffold.dart';
import 'package:flutter/material.dart';

class TutorHome extends StatelessWidget {
  const TutorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerScaffold(
      title: "Tutor Home",
      role: "Tutor",
      body: Center(
        child: Text("Welcome Tutor 👨‍🏫"),
      ),
    );
  }
}
