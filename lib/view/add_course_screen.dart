import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../database/db_helper.dart';

class AddCourseScreen extends StatefulWidget {
  final Map<String, dynamic>? existingCourse;
  final int? courseId;

  const AddCourseScreen({super.key, this.existingCourse, this.courseId});

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  late final FormGroup form;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();

    isEditing = widget.existingCourse != null;

    form = FormGroup({
      'name': FormControl<String>(
        value: widget.existingCourse != null ? widget.existingCourse!['name'] : null,
        validators: [Validators.required],
      ),
      'education': FormControl<String>(
        value: widget.existingCourse != null ? widget.existingCourse!['education'] : null,
        validators: [Validators.required],
      ),
      'format': FormControl<String>(
        value: widget.existingCourse != null ? widget.existingCourse!['format'] : 'Objective',
        validators: [Validators.required],
      ),
      'level': FormControl<String>(
        value: widget.existingCourse != null ? widget.existingCourse!['level'] : 'Easy',
        validators: [Validators.required],
      ),
      'date': FormControl<String>(
        value: widget.existingCourse != null ? widget.existingCourse!['examDate'] : null,
        validators: [Validators.required],
      ),
      'address': FormControl<String>(
        value: widget.existingCourse != null ? widget.existingCourse!['address'] : null,
        validators: [Validators.required],
      ),
      'includeAnswers': FormControl<bool>(
        value: widget.existingCourse != null 
            ? (widget.existingCourse!['includeAnswers'] == 1 || widget.existingCourse!['includeAnswers'] == true)
            : false,
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
      form.control('date').value = "${picked.year}-${picked.month}-${picked.day}";
    }
  }

  void submit(BuildContext context) async {
    if (form.valid) {
      final value = form.value;

      Map<String, dynamic> courseData = {
        'name': value["name"],
        'education': value["education"],
        'format': value["format"],
        'level': value["level"],
        'examDate': value["date"],
        'address': value["address"],
        'includeAnswers': value["includeAnswers"] == true ? 1 : 0,
      };

      int result;
      if (isEditing) {
        result = await DBHelper().updateCourse(widget.courseId!, courseData);
        if (result > 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Course updated successfully!")),
          );
        }
      } else {
        result = await DBHelper().insertCourse(courseData);
        if (result > 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Course added successfully!")),
          );
        }
      }

      Navigator.pop(context, true);
    } else {
      form.markAllAsTouched();
    }
  }

  InputDecoration fieldStyle(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Color(0xFF0D47A1)),
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.orange),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF0D47A1)),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit Course" : "Add Course"),
        backgroundColor: Color(0xFF0D47A1),
      ),
      body: ReactiveForm(
        formGroup: form,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              ReactiveTextField<String>(
                formControlName: 'name',
                decoration: fieldStyle("Course Name"),
                validationMessages: {
                  ValidationMessage.required: (_) => "Course name is required",
                },
              ),
              SizedBox(height: 15),
              ReactiveTextField<String>(
                formControlName: 'education',
                decoration: fieldStyle("Education"),
                validationMessages: {
                  ValidationMessage.required: (_) => "Education is required",
                },
              ),
              SizedBox(height: 15),
              ReactiveDropdownField<String>(
                formControlName: 'format',
                decoration: fieldStyle("Exam Format"),
                items: ['Objective', 'Theory']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                validationMessages: {
                  ValidationMessage.required: (_) => "Select exam format",
                },
              ),
              SizedBox(height: 15),
              ReactiveDropdownField<String>(
                formControlName: 'level',
                decoration: fieldStyle("Difficulty Level"),
                items: ['Easy', 'Medium', 'Hard']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                validationMessages: {
                  ValidationMessage.required: (_) => "Select difficulty level",
                },
              ),
              SizedBox(height: 15),
              ReactiveTextField<String>(
                formControlName: 'date',
                readOnly: true,
                onTap: (_) => pickDate(),
                decoration: fieldStyle("Exam Date"),
                validationMessages: {
                  ValidationMessage.required: (_) => "Exam date is required",
                },
              ),
              SizedBox(height: 15),
              ReactiveTextField<String>(
                formControlName: 'address',
                decoration: fieldStyle("Address"),
                validationMessages: {
                  ValidationMessage.required: (_) => "Address is required",
                },
              ),
              SizedBox(height: 20),
              ReactiveFormConsumer(
                builder: (context, form, child) {
                  bool include = form.control('includeAnswers').value ?? false;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
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
              SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0D47A1),
                  ),
                  onPressed: () => submit(context),
                  child: Text(
                    isEditing ? "Update Course" : "Add Course",
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