import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class AppStyles {
  // BACKGROUND
  static BoxDecoration background() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: AppColors.backgroundGradient,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }

  // GLASS CARD
  static BoxDecoration glassCard() {
    return BoxDecoration(
      color: Colors.white.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
    );
  }

  // BUTTON STYLE
  static ButtonStyle primaryButton() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  // INPUT FIELDs
  static InputDecoration input(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.85),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
