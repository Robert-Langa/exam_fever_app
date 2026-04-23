import 'package:flutter/material.dart';

class ViewMap extends StatelessWidget {
  const ViewMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          "Map will be displayed here",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
