import 'package:exam_fever_app/core/app_theme.dart';
import 'package:exam_fever_app/core/theme_controller.dart';
import 'package:exam_fever_app/views/settings.dart';
import 'package:flutter/material.dart';
import 'views/login_screen.dart';
import 'views/signup_screen.dart';
import 'views/forgot_password_screen.dart';
import 'views/splash_screen.dart';
import 'views/student_home.dart';
import 'views/tutor_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeMode,
      builder: (context, mode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: mode,

          initialRoute: '/splash',
          routes: {
            '/splash': (context) => SplashScreen(),
            '/login': (context) => LoginScreen(),
            '/signup': (context) => SignupScreen(),
            '/forgot': (context) => ForgotPasswordScreen(),
            '/student': (context) => StudentHome(),
            '/tutor': (context) => TutorHome(),
            '/settings': (context) => Settings(),
          },
        );
      },
    );
  }
}
