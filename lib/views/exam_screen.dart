import 'package:flutter/material.dart';
import '../core/app_colors.dart';

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
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: Text("Exam - ${widget.courseName}"),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
      ),

      body: submitted
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.emoji_events,
                    size: 90,
                    color: AppColors.accentOrange,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Exam Completed",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Score: $score / ${questions.length}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: AppColors.white,
                    ),
                    onPressed: exitExam,
                    child: const Text("Exit"),
                  )
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Question ${currentIndex + 1} / ${questions.length}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Center(
                    child: Text(
                      question["question"],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  ...List.generate(
                    question["options"].length,
                    (index) => GestureDetector(
                      onTap: () => selectOption(index),
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: selectedIndex == index
                                ? AppColors.accentOrange
                                : AppColors.primaryBlue.withOpacity(0.3),
                            width: selectedIndex == index ? 2 : 1,
                          ),
                          color: selectedIndex == index
                              ? AppColors.accentOrange.withOpacity(0.15)
                              : Colors.transparent,
                        ),
                        child: Text(
                          question["options"][index],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primaryBlue,
                            side: const BorderSide(
                              color: AppColors.primaryBlue,
                            ),
                          ),
                          onPressed: exitExam,
                          child: const Text("Exit"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accentOrange,
                            foregroundColor: AppColors.white,
                          ),
                          onPressed:
                              selectedIndex == null ? null : nextQuestion,
                          child: Text(
                            currentIndex == questions.length - 1
                                ? "Submit"
                                : "Next",
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
