import 'package:exam_fever_app/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({super.key});

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  late final FormGroup form;

  @override
  void initState() {
    super.initState();

    form = FormGroup({
      'name': FormControl<String>(validators: [Validators.required]),
      'education': FormControl<String>(validators: [Validators.required]),
      'format': FormControl<String>(
        value: 'Objective',
        validators: [Validators.required],
      ),
      'level': FormControl<String>(
        value: 'Easy',
        validators: [Validators.required],
      ),
      'date': FormControl<String>(validators: [Validators.required]),
      'address': FormControl<String>(validators: [Validators.required]),
      'includeAnswers': FormControl<bool>(value: false),
    });
  }

  Future pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      form.control('date').value =
          "${picked.year}-${picked.month}-${picked.day}";
    }
  }

  void submit() {
    if (form.valid) {
      final value = form.value;

      Navigator.pop(context, {
        "name": value["name"],
        "education": value["education"],
        "format": value["format"],
        "level": value["level"],
        "examDate": value["date"],
        "address": value["address"],
        "includeAnswers": value["includeAnswers"] == true ? 1 : 0,
      });
    } else {
      form.markAllAsTouched();
    }
  }

  InputDecoration fieldStyle(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: AppColors.primaryBlue),
      labelStyle: const TextStyle(color: AppColors.primaryBlue),
      border: const OutlineInputBorder(),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.accentOrange),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryBlue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("Add Course"),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
      ),

      body: ReactiveForm(
        formGroup: form,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              ReactiveTextField(
                formControlName: 'name',
                decoration: fieldStyle("Course Name", Icons.book),
              ),
              const SizedBox(height: 10),

              ReactiveTextField(
                formControlName: 'education',
                decoration: fieldStyle("Education", Icons.school),
              ),
              const SizedBox(height: 10),

              ReactiveDropdownField(
                formControlName: 'format',
                decoration: fieldStyle("Format", Icons.list_alt),
                items: ['Objective', 'Theory']
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 10),

              ReactiveDropdownField(
                formControlName: 'level',
                decoration: fieldStyle("Level", Icons.trending_up),
                items: ['Easy', 'Medium', 'Hard']
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 10),

              ReactiveTextField(
                formControlName: 'date',
                readOnly: true,
                onTap: (_) => pickDate(),
                decoration: fieldStyle("Exam Date", Icons.calendar_month),
              ),
              const SizedBox(height: 10),

              ReactiveTextField(
                formControlName: 'address',
                decoration: fieldStyle("Address", Icons.location_on),
              ),

              const SizedBox(height: 10),

              ReactiveFormConsumer(
                builder: (context, form, child) {
                  return SwitchListTile(
                    activeColor: AppColors.accentOrange,
                    title: const Text("Include Answers"),
                    value: form.control('includeAnswers').value ?? false,
                    onChanged: (val) {
                      form.control('includeAnswers').value = val;
                    },
                  );
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentOrange,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: submit,
                child: const Text(
                  "Save Course",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
