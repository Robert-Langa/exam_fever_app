import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadNotesScreen extends StatefulWidget {
  const UploadNotesScreen({super.key});

  @override
  State<UploadNotesScreen> createState() => _UploadNotesScreenState();
}

class _UploadNotesScreenState extends State<UploadNotesScreen> {
  String fileName = "No file selected";

  Future pickFile() async {
    FilePickerResult? result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx'],
    );

    if (result != null) {
      setState(() {
        fileName = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Notes"),
        backgroundColor: const Color(0xFF0D47A1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.upload_file, size: 80, color: Color(0xFF0D47A1)),

            const SizedBox(height: 20),

            Text(fileName, style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: pickFile,
              child: const Text("Choose File"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D47A1),
              ),
              onPressed: () {},
              child: const Text("Upload"),
            ),
          ],
        ),
      ),
    );
  }
}
