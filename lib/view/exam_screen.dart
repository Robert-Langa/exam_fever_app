import 'package:flutter/material.dart';

class ExamScreen extends StatefulWidget {
  final String courseName;

  const ExamScreen({super.key, required this.courseName});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      "question": "What is 2 + 2?",
      "options": ["3", "4", "5", "6"],
      "answer": 1
    },
    {
      "question": "What is the capital of Canada?",
      "options": ["Toronto", "Ottawa", "Vancouver", "Montreal"],
      "answer": 1
    },
    {
      "question": "Which is a programming language?",
      "options": ["HTML", "CSS", "Python", "Photoshop"],
      "answer": 2
    },
  ];

  int currentIndex = 0;
  int score = 0;
  int? selectedIndex;
  bool submitted = false;

  static const primary = Color(0xFF0D47A1);
  static const accent = Colors.orange;

  void selectOption(int index) {
    if (submitted) return;

    setState(() {
      selectedIndex = index;
    });
  }

  void nextQuestion() {
    if (selectedIndex == questions[currentIndex]["answer"]) {
      score++;
    }

    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
        selectedIndex = null;
      });
    } else {
      setState(() {
        submitted = true;
      });
    }
  }

  void exitExam() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Exam - ${widget.courseName}"),
        backgroundColor: primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: submitted
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.emoji_events,
                      size: 80,
                      color: accent,
                    ),

                    SizedBox(height: 15),

                    Text(
                      "Exam Completed",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: primary,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Score: $score / ${questions.length}",
                      style: TextStyle(fontSize: 20),
                    ),

                    SizedBox(height: 20),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                      ),
                      onPressed: exitExam,
                      child: Text(
                        "Exit",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Question ${currentIndex + 1}/${questions.length}",
                    style: TextStyle(
                      fontSize: 18,
                      color: primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 15),

                  Text(
                    question["question"],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 20),

                  ...List.generate(
                    question["options"].length,
                    (index) => GestureDetector(
                      onTap: () => selectOption(index),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: selectedIndex == index
                                ? accent
                                : Colors.grey,
                            width: selectedIndex == index ? 2 : 1,
                          ),
                          color: selectedIndex == index
                              ? accent.withOpacity(0.1)
                              : Colors.transparent,
                        ),
                        child: Text(question["options"][index]),
                      ),
                    ),
                  ),

                  Spacer(),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: primary,
                            side: BorderSide(color: primary),
                          ),
                          onPressed: exitExam,
                          child: Text("Exit"),
                        ),
                      ),

                      SizedBox(width: 10),

                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accent,
                          ),
                          onPressed:
                              selectedIndex == null ? null : nextQuestion,
                          child: Text(
                            currentIndex == questions.length - 1
                                ? "Submit"
                                : "Next",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
