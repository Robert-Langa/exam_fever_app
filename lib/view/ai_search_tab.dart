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
              result.isEmpty ? "AI Search Coming Soon" : result,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.fromLTRB(12, 10, 12, 20),
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: "Ask something...",
                        border: InputBorder.none,
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
          ),
        ),
      ],
    );
  }
}
