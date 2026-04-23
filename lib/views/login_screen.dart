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
      backgroundColor: AppColors.background,

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
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: const TextStyle(color: AppColors.primaryBlue),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.accentOrange),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryBlue),
                  ),
                  prefixIcon: const Icon(
                    Icons.email,
                    color: AppColors.primaryBlue,
                  ),
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
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: const TextStyle(color: AppColors.primaryBlue),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.accentOrange),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryBlue),
                  ),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: AppColors.primaryBlue,
                  ),
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
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.accentOrange,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentOrange,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  if (form.valid) {
                    final password =
                        form.control('password').value?.toString();

                    if (password == "student") {
                      Navigator.pushReplacementNamed(context, '/student');
                    } else if (password == "tutor") {
                      Navigator.pushReplacementNamed(context, '/tutor');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Invalid credentials"),
                        ),
                      );
                    }
                  } else {
                    form.markAllAsTouched();
                  }
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "New user to ExamFever? ",
                    style: TextStyle(color: AppColors.primaryBlue),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        color: AppColors.primaryBlue,
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
