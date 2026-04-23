import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    colorScheme: ColorScheme.light(
      primary: AppColors.primaryBlue,
      secondary: AppColors.gold,
      background: AppColors.background,
    ),

    scaffoldBackgroundColor: AppColors.background,

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryBlue,
      foregroundColor: AppColors.white,
      centerTitle: true,
    ),

    tabBarTheme: TabBarThemeData(
      labelColor: AppColors.gold,
      unselectedLabelColor: Colors.black54,
      indicatorColor: AppColors.gold,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.gold,
        foregroundColor: AppColors.white,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.gold),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryBlue),
      ),
      border: OutlineInputBorder(),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,

    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryBlue,
      secondary: AppColors.gold,
    ),

    scaffoldBackgroundColor: Colors.black,

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryBlue,
      foregroundColor: AppColors.white,
      centerTitle: true,
    ),

    tabBarTheme: TabBarThemeData(
      labelColor: AppColors.gold,
      unselectedLabelColor: Colors.white70,
      indicatorColor: AppColors.gold,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.gold,
        foregroundColor: AppColors.black,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.gold),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryBlue),
      ),
      border: OutlineInputBorder(),
    ),
  );
}
