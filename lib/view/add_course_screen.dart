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
      'name': FormControl<String>(
        validators: [Validators.required],
      ),

      'education': FormControl<String>(
        validators: [Validators.required],
      ),

      'format': FormControl<String>(
        value: 'Objective',
        validators: [Validators.required],
      ),

      'level': FormControl<String>(
        value: 'Easy',
        validators: [Validators.required],
      ),

      'date': FormControl<String>(
        validators: [Validators.required],
      ),

      // ✅ ADDRESS (required)
      'address': FormControl<String>(
        validators: [Validators.required],
      ),

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

  void submit(BuildContext context) {
    if (form.valid) {
      final value = form.value;

      Navigator.pop(context, {
        "name": value["name"],
        "education": value["education"],
        "format": value["format"],
        "level": value["level"],
        "date": value["date"],

        // ✅ FIXED HERE (was location before)
        "address": value["address"],

        "includeAnswers": value["includeAnswers"] ?? false,
      });
    } else {
      form.markAllAsTouched();
    }
  }

  InputDecoration fieldStyle(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xFF0D47A1)),
      border: const OutlineInputBorder(),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.orange),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF0D47A1)),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Course"),
        backgroundColor: const Color(0xFF0D47A1),
      ),
      body: ReactiveForm(
        formGroup: form,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              ReactiveTextField<String>(
                formControlName: 'name',
                decoration: fieldStyle("Course Name"),
                validationMessages: {
                  ValidationMessage.required: (_) =>
                      "Course name is required",
                },
              ),

              const SizedBox(height: 15),

              ReactiveTextField<String>(
                formControlName: 'education',
                decoration: fieldStyle("Education"),
                validationMessages: {
                  ValidationMessage.required: (_) =>
                      "Education is required",
                },
              ),

              const SizedBox(height: 15),

              ReactiveDropdownField<String>(
                formControlName: 'format',
                decoration: fieldStyle("Exam Format"),
                items: ['Objective', 'Theory']
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                validationMessages: {
                  ValidationMessage.required: (_) =>
                      "Select exam format",
                },
              ),

              const SizedBox(height: 15),

              ReactiveDropdownField<String>(
                formControlName: 'level',
                decoration: fieldStyle("Difficulty Level"),
                items: ['Easy', 'Medium', 'Hard']
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                validationMessages: {
                  ValidationMessage.required: (_) =>
                      "Select difficulty level",
                },
              ),

              const SizedBox(height: 15),

              ReactiveTextField<String>(
                formControlName: 'date',
                readOnly: true,
                onTap: (_) => pickDate(),
                decoration: fieldStyle("Exam Date"),
                validationMessages: {
                  ValidationMessage.required: (_) =>
                      "Exam date is required",
                },
              ),

              const SizedBox(height: 15),

              ReactiveTextField<String>(
                formControlName: 'address',
                decoration: fieldStyle("Address"),
                validationMessages: {
                  ValidationMessage.required: (_) =>
                      "Address is required",
                },
              ),

              const SizedBox(height: 20),

              ReactiveFormConsumer(
                builder: (context, form, child) {
                  bool include =
                      form.control('includeAnswers').value ?? false;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Include Answers",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF0D47A1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Switch(
                        activeColor: Colors.orange,
                        value: include,
                        onChanged: (val) {
                          form.control('includeAnswers').value = val;
                        },
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D47A1),
                  ),
                  onPressed: () => submit(context),
                  child: const Text(
                    "Add Course",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
