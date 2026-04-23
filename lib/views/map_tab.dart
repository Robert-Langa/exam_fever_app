import 'package:flutter/material.dart';
import 'view_map.dart';
import '../core/app_colors.dart';
import 'active_questions_tab.dart';

class MapTab extends StatelessWidget {
  final VoidCallback? onChatTap;

  const MapTab({super.key, this.onChatTap});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            indicatorColor: AppColors.accentOrange,
            labelColor: AppColors.accentOrange,
            unselectedLabelColor: AppColors.primaryBlue,
            tabs: const [
              Tab(
                text: "View Map",
                icon: Icon(Icons.map),
              ),
              Tab(
                text: "Active Questions",
                icon: Icon(Icons.list),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                ViewMap(onMarkerTap: onChatTap!),
                ActiveQuestions(
                  onChatTap: (a, b) {
                    if (onChatTap != null) onChatTap!();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
