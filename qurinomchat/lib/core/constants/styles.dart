import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qurinomchat/core/constants/colors.dart';
import '';

class AppTextStyles {
  static final TextStyle headline1 = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static final TextStyle headline2 = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static final TextStyle subtitle1 = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static final TextStyle body1 = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static final TextStyle body2 = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static final TextStyle caption = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static final TextStyle button = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}