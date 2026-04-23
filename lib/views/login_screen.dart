import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../core/app_colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final FormGroup form = FormGroup({
    'email': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    'password': FormControl<String>(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: Padding(
        padding: EdgeInsets.all(20),
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/exam_fever_logo.png', width: 260),

              SizedBox(height: 30),

              ReactiveTextField<String>(
                formControlName: 'email',
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: AppColors.primaryBlue),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.accentOrange),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryBlue),
                  ),
                  prefixIcon: Icon(Icons.email, color: AppColors.primaryBlue),
                ),
                validationMessages: {
                  ValidationMessage.required: (_) => 'Email is required',
                  ValidationMessage.email: (_) => 'Enter a valid email',
                },
              ),

              SizedBox(height: 10),

              ReactiveTextField<String>(
                formControlName: 'password',
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(color: AppColors.primaryBlue),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.accentOrange),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryBlue),
                  ),
                  prefixIcon: Icon(Icons.lock, color: AppColors.primaryBlue),
                ),
                validationMessages: {
                  ValidationMessage.required: (_) => 'Password is required',
                },
              ),

              SizedBox(height: 5),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgot');
                  },
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.accentOrange,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentOrange,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
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
                        SnackBar(content: Text("Invalid credentials")),
                      );
                    }
                  } else {
                    form.markAllAsTouched();
                  }
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New user to ExamFever? ",
                    style: TextStyle(color: AppColors.primaryBlue),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
