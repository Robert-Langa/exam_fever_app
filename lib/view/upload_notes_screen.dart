import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadNotesScreen extends StatefulWidget {
  UploadNotesScreen({super.key});

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
        title: Text("Upload Notes"),
        backgroundColor: Color(0xFF0D47A1),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(Icons.upload_file, size: 80, color: Color(0xFF0D47A1)),

            SizedBox(height: 20),

            Text(fileName, style: TextStyle(fontSize: 16)),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: pickFile,
              child: Text("Choose File"),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0D47A1),
              ),
              onPressed: () {},
              child: Text("Upload"),
            ),
          ],
        ),
      ),
    );
  }
}
