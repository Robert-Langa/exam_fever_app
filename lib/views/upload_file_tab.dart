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

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Uploading $fileName")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No file selected")),
      );
    }
  }

  void cancelFile() {
    setState(() {
      fileName = "No file selected";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Selection cleared")),
    );
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

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    fileName,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                SizedBox(width: 8),

                if (fileName != "No file selected")
                  GestureDetector(
                    onTap: cancelFile,
                    child: Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 22,
                    ),
                  ),
              ],
            ),

            SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0D47A1),
              ),
              onPressed: pickAndUploadFile,
              child: Text(
                "Upload",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
