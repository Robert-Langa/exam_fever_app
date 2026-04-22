import 'package:flutter/material.dart';
import '../core/app_style.dart';

class UploadNotesScreen extends StatelessWidget {
  const UploadNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppStyles.background(),

        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: AppStyles.glassCard(),

              child: Column(
                children: [
                  const Text(
                    "Upload Notes",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextField(decoration: AppStyles.input("Title")),

                  const SizedBox(height: 15),

                  TextField(
                    maxLines: 3,
                    decoration: AppStyles.input("Description"),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    style: AppStyles.primaryButton(),
                    onPressed: () {},
                    child: const Text("Choose File"),
                  ),

                  const SizedBox(height: 15),

                  ElevatedButton(
                    style: AppStyles.primaryButton(),
                    onPressed: () {},
                    child: const Text("Upload"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
