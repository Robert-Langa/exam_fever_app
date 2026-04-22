import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadFileTab extends StatefulWidget {
  const UploadFileTab({super.key});

  @override
  State<UploadFileTab> createState() => _UploadFileTabState();
}

class _UploadFileTabState extends State<UploadFileTab> {
  String fileName = "No file selected";

  Future pickAndUploadFile() async {
    FilePickerResult? result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'png', 'jpg', 'jpeg', 'pptx'],
    );

    if (result != null) {
      setState(() {
        fileName = result.files.single.name;
      });

      // Simulate upload
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Uploading $fileName")),
      );
    } else {
      // User canceled
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No file selected")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.upload_file,
              size: 110,
              color: Color(0xFF0D47A1),
            ),
            SizedBox(height: 30),
            Text(
              fileName,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0D47A1),
              ),
              onPressed: pickAndUploadFile,
              child: Text("Upload", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
