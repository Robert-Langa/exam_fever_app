import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EditCourseScreen extends StatefulWidget {
  final Map<String, dynamic> course;

  const EditCourseScreen({super.key, required this.course});

  @override
  State<EditCourseScreen> createState() => _EditCourseScreenState();
}

class _EditCourseScreenState extends State<EditCourseScreen> {
  late final FormGroup form;

  @override
  void initState() {
    super.initState();

    form = FormGroup({
      'name': FormControl<String>(
        value: widget.course['name'],
        validators: [Validators.required],
      ),
      'education': FormControl<String>(
        value: widget.course['education'],
        validators: [Validators.required],
      ),
      'format': FormControl<String>(
        value: widget.course['format'],
        validators: [Validators.required],
      ),
      'level': FormControl<String>(
        value: widget.course['level'],
        validators: [Validators.required],
      ),
      'date': FormControl<String>(
        value: widget.course['examDate'],
        validators: [Validators.required],
      ),
      'address': FormControl<String>(
        value: widget.course['address'],
        validators: [Validators.required],
      ),
      'includeAnswers': FormControl<bool>(
        value: widget.course['includeAnswers'] == 1,
      ),
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

  InputDecoration fieldStyle(String label) {
    return const InputDecoration(
      border: OutlineInputBorder(),
    ).copyWith(labelText: label);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Course"),
        backgroundColor: const Color(0xFF0D47A1),
      ),
      body: ReactiveForm(
        formGroup: form,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              ReactiveTextField(
                formControlName: 'name',
                decoration: fieldStyle("Course Name"),
              ),
              const SizedBox(height: 10),
              ReactiveTextField(
                formControlName: 'education',
                decoration: fieldStyle("Education"),
              ),
              const SizedBox(height: 10),
              ReactiveDropdownField(
                formControlName: 'format',
                decoration: fieldStyle("Format"),
                items: ['Objective', 'Theory']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
              ),
              const SizedBox(height: 10),
              ReactiveDropdownField(
                formControlName: 'level',
                decoration: fieldStyle("Level"),
                items: ['Easy', 'Medium', 'Hard']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
              ),
              const SizedBox(height: 10),
              ReactiveTextField(
                formControlName: 'date',
                readOnly: true,
                onTap: (_) => pickDate(),
                decoration: fieldStyle("Exam Date"),
              ),
              const SizedBox(height: 10),
              ReactiveTextField(
                formControlName: 'address',
                decoration: fieldStyle("Address"),
              ),
              const SizedBox(height: 10),
              ReactiveFormConsumer(
                builder: (context, form, child) {
                  return SwitchListTile(
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
                onPressed: submit,
                child: const Text("Update Course"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
