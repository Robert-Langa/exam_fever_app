import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Text editing controller
  final TextEditingController _feedbackController = TextEditingController();

  // Variables for feedback data
  int _rating = 0;
  String _selectedCategory = 'General';
  bool _isSubmitting = false;

  // Categories list
  final List<String> _categories = [
    'General',
    'Exam Content',
    'Technical Issue',
    'UI/UX',
    'Feature Request',
    'Other',
  ];

  // Rating labels map
  final Map<int, String> _ratingLabels = {
    1: 'Very Poor',
    2: 'Poor',
    3: 'Average',
    4: 'Good',
    5: 'Excellent',
  };

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _submitFeedback() {
    // Validate form
    if (!_formKey.currentState!.validate()) return;

    // Check if rating is provided
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please provide a rating'),
          backgroundColor: AppColors.accentOrange,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // Simulate API call (replace with actual API)
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
        _showSuccessDialog();

        // Clear form after successful submission
        _feedbackController.clear();
        _rating = 0;
        _selectedCategory = 'General';
      }
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 32),
            const SizedBox(width: 12),
            Text(
              'Thank You!',
              style: TextStyle(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: const Text(
          'Your feedback has been submitted successfully.\n\nWe appreciate your input to help us improve.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to previous screen
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.primaryBlue),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _resetForm() {
    setState(() {
      _feedbackController.clear();
      _rating = 0;
      _selectedCategory = 'General';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Feedback"),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Center(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.feedback_outlined,
                          size: 60,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'We value your feedback!',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Help us improve your experience',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryBlue.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Rating Section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primaryBlue.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'How would you rate your experience?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(5, (int index) {
                          final int ratingValue = index + 1;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _rating = ratingValue;
                              });
                            },
                            child: Column(
                              children: [
                                Icon(
                                  ratingValue <= _rating
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: ratingValue <= _rating
                                      ? AppColors.accentOrange
                                      : Colors.grey,
                                  size: 40,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _ratingLabels[ratingValue]!.split(' ').first,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: ratingValue <= _rating
                                        ? AppColors.accentOrange
                                        : Colors.grey,
                                    fontWeight: ratingValue <= _rating
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                      if (_rating > 0)
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Center(
                            child: Text(
                              _ratingLabels[_rating]!,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.accentOrange,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Category Section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primaryBlue.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Category',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: _categories.map((String category) {
                          final bool isSelected = _selectedCategory == category;
                          return FilterChip(
                            label: Text(category),
                            selected: isSelected,
                            onSelected: (bool selected) {
                              setState(() {
                                _selectedCategory = category;
                              });
                            },
                            backgroundColor: AppColors.white,
                            selectedColor: AppColors.accentOrange.withOpacity(
                              0.2,
                            ),
                            checkmarkColor: AppColors.accentOrange,
                            labelStyle: TextStyle(
                              color: isSelected
                                  ? AppColors.accentOrange
                                  : AppColors.primaryBlue.withOpacity(0.7),
                              fontWeight: isSelected
                                  ? FontWeight.w500
                                  : FontWeight.normal,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Feedback Text Field Section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primaryBlue.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Feedback',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _feedbackController,
                        maxLines: 6,
                        maxLength: 500,
                        decoration: InputDecoration(
                          hintText:
                              'Please share your thoughts, suggestions, or report any issues...',
                          hintStyle: TextStyle(
                            color: AppColors.primaryBlue.withOpacity(0.5),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.primaryBlue.withOpacity(0.3),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.primaryBlue.withOpacity(0.3),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: AppColors.primaryBlue,
                              width: 2,
                            ),
                          ),
                          filled: true,
                          fillColor: AppColors.white,
                        ),
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your feedback';
                          }
                          if (value.trim().length < 10) {
                            return 'Please provide more detailed feedback (minimum 10 characters)';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Buttons Row
                Row(
                  children: [
                    // Reset Button
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primaryBlue,
                          side: BorderSide(color: AppColors.primaryBlue),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: _resetForm,
                        child: const Text("Reset"),
                      ),
                    ),

                    const SizedBox(width: 10),

                    // Submit Button
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentOrange,
                          foregroundColor: AppColors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: _isSubmitting ? null : _submitFeedback,
                        child: _isSubmitting
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text("Submit Feedback"),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
