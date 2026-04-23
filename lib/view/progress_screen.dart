import 'package:flutter/material.dart';
import 'package:exam_fever_app/database/db_helper.dart';
import 'package:exam_fever_app/core/app_colors.dart';

class ProgressScreen extends StatefulWidget {
  final int userId;
  const ProgressScreen({super.key, required this.userId});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  List<Map<String, dynamic>> results = [];
  bool isLoading = true;
  int totalExams = 0;
  double averageScore = 0.0;

  static const primary = Color(0xFF0D47A1);
  static const accent = Colors.orange;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    setState(() => isLoading = true);

    final data = await DBHelper().getResultsByUser(widget.userId);

    setState(() {
      results = data;
      totalExams = results.length;

      int totalScore = 0;
      for (var r in results) {
        totalScore += r['score'] as int;
      }
      averageScore = totalExams > 0 ? totalScore / totalExams : 0.0;

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Progress"),
        backgroundColor: primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : results.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bar_chart, size: 80, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      const Text(
                        "No progress yet",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Complete exams to see your progress",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    // Stats Cards
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Text(
                                      "$totalExams",
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: primary,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text("Exams Completed"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Card(
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Text(
                                      "${averageScore.toStringAsFixed(1)}%",
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: accent,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text("Average Score"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Results List
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Recent Results",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final result = results[index];
                          int score = result['score'];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            child: ListTile(
                              leading: Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.assignment_turned_in, color: primary),
                              ),
                              title: Text(
                                result['courseName'],
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "Completed: ${result['completedDate']}",
                              ),
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: score >= 70
                                      ? Colors.green
                                      : score >= 50
                                          ? accent
                                          : Colors.red,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "$score%",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}