import 'package:flutter/material.dart';
import 'view/login_screen.dart';
import 'view/signup_screen.dart';
import 'view/forgot_password_screen.dart';
import 'view/splash_screen.dart';
import 'view/student_home.dart';
import 'view/tutor_home.dart';
import 'view/upload_notes_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: '/splash',

      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/forgot': (context) => ForgotPasswordScreen(),
        '/student': (context) => const StudentHome(),
        '/tutor': (context) => const TutorHome(),
        '/upload': (context) => UploadNotesScreen(),
      },
    );
  }
}
