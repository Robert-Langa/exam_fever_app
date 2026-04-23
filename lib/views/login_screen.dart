import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../core/app_colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final FormGroup form = FormGroup({
    'email': FormControl<String>(
      validators: [
        Validators.required,
        Validators.email,
      ],
    ),
    'password': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/exam_fever_logo.png', width: 260),

              const SizedBox(height: 30),

              ReactiveTextField<String>(
                formControlName: 'email',
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validationMessages: {
                  ValidationMessage.required: (_) => 'Email is required',
                  ValidationMessage.email: (_) => 'Enter a valid email',
                },
              ),

              const SizedBox(height: 10),

              ReactiveTextField<String>(
                formControlName: 'password',
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                validationMessages: {
                  ValidationMessage.required: (_) => 'Password is required',
                },
              ),

              const SizedBox(height: 5),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgot');
                  },
                  child: const Text(
                    "Forgot password?",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  if (form.valid) {
                    final password = form.control('password').value?.toString();

                    if (password == "student") {
                      Navigator.pushReplacementNamed(context, '/student');
                    } else if (password == "tutor") {
                      Navigator.pushReplacementNamed(context, '/tutor');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Invalid credentials")),
                      );
                    }
                  } else {
                    form.markAllAsTouched();
                  }
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: AppColors.white),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "New user to ExamFever? ",
                    style: TextStyle(color: AppColors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
