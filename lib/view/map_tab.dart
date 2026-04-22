import 'package:flutter/material.dart';

class MapTab extends StatelessWidget {
  const MapTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.orange,
            tabs: [
              Tab(text: "View Map"),
              Tab(text: "Locations"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                Center(child: Text("Map View Screen")),
                Center(child: Text("Saved Locations Screen")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
