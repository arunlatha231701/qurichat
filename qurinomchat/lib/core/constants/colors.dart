import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF6C63FF);
  static const Color secondary = Color(0xFF4A44B7);
  static const Color background = Color(0xFFF8F9FA);
  static const Color card = Colors.white;
  static const Color textPrimary = Color(0xFF2D3748);
  static const Color textSecondary = Color(0xFF718096);
  static const Color success = Color(0xFF48BB78);
  static const Color error = Color(0xFFE53E3E);
  static const Color typingIndicator = Color(0xFFA0AEC0);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}