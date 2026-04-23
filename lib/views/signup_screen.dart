import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../core/app_colors.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final FormGroup form = FormGroup(
    {
      'firstName': FormControl<String>(validators: [Validators.required]),
      'lastName': FormControl<String>(validators: [Validators.required]),
      'email': FormControl<String>(
        validators: [Validators.required, Validators.email],
      ),
      'password': FormControl<String>(
        validators: [Validators.required, Validators.minLength(6)],
      ),
      'retypePassword': FormControl<String>(validators: [Validators.required]),
      'role': FormControl<String>(validators: [Validators.required]),
    },
    validators: [Validators.mustMatch('password', 'retypePassword')],
  );

  InputDecoration _dec(String label) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
      prefixIcon: const Icon(Icons.person),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Account")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ReactiveForm(
          formGroup: form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/images/exam_fever_logo.png', width: 200),

                SizedBox(height: 20),

                ReactiveTextField<String>(
                  formControlName: 'firstName',
                  decoration: _dec("First Name"),
                ),

                SizedBox(height: 10),

                ReactiveTextField<String>(
                  formControlName: 'lastName',
                  decoration: _dec("Last Name"),
                ),

                SizedBox(height: 10),

                ReactiveTextField<String>(
                  formControlName: 'email',
                  decoration: _dec("Email"),
                ),

                SizedBox(height: 10),

                ReactiveTextField<String>(
                  formControlName: 'password',
                  obscureText: true,
                  decoration: _dec("Password"),
                ),

                SizedBox(height: 10),

                ReactiveTextField<String>(
                  formControlName: 'retypePassword',
                  obscureText: true,
                  decoration: _dec("Retype Password"),
                ),

                SizedBox(height: 10),

                ReactiveDropdownField<String>(
                  formControlName: 'role',
                  decoration: _dec("Select Role"),
                  items: [
                    DropdownMenuItem(value: "student", child: Text("Student")),
                    DropdownMenuItem(value: "tutor", child: Text("Tutor")),
                  ],
                ),

                SizedBox(height: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 220, 179, 15),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    if (form.valid) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) => false,
                      );
                    } else {
                      form.markAllAsTouched();
                    }
                  },
                  child: Text(
                    "Create Account",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
