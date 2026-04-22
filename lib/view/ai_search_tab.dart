import 'package:flutter/material.dart';

class AiSearchTab extends StatefulWidget {
  const AiSearchTab({super.key});

  @override
  State<AiSearchTab> createState() => _AiSearchTabState();
}

class _AiSearchTabState extends State<AiSearchTab> {
  final TextEditingController controller = TextEditingController();
  String result = "";

  void search() {
    setState(() {
      result = controller.text.isEmpty
          ? "Please enter something"
          : "Result for: ${controller.text}";
    });
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Text(
              result.isEmpty ? "AI Search Coming Soon 🤖" : result,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: "Ask something...",
                  ),
                ),
              ),
              IconButton(
                onPressed: search,
                icon: Icon(Icons.send),
              )
            ],
          ),
        ),
      ],
    );
  }
}
