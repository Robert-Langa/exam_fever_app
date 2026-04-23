import 'package:exam_fever_app/core/app_theme.dart';
import 'package:exam_fever_app/core/theme_controller.dart';
import 'package:exam_fever_app/view/settings.dart';
import 'package:flutter/material.dart';
import 'view/login_screen.dart';
import 'view/signup_screen.dart';
import 'view/forgot_password_screen.dart';
import 'view/splash_screen.dart';
import 'view/student_home.dart';
import 'view/tutor_home.dart';
import 'view/view_map.dart';
import 'view/progress_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();  // Load .env file
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
            '/viewMap': (context) => ViewMap(),
            '/progress': (context) => ProgressScreen(userId: 1),
            
          },
        );
      },
    );
  }
}
