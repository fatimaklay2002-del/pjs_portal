import 'package:flutter/material.dart';
class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primaryNavy = Color(0xFF0D2B4E);
  static const Color lightNavy = Color(0xFF1F4E7A);
  static const Color whiteBlue = Color(0xFFEDF3F9);

  // Background Colors
  static const Color background = Color(0xFFF8F9FA);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // Text Colors
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF60748D);
  static const Color textHint = Color(0xff64748B);

  // Accent Colors
  static const Color accentYellow = Color(0xFFFBBF24);
  static const Color accentBlue = Color(0xFF1976D2);
  static const Color accentRed = Color(0xFFE53935);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF1E293B);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color lightGrey = Color(0xFF64748B);
  static const Color darktGrey = Color(0xFF334155);
  static const Color divider = Color(0xFFE2E8F0);

  // Input Field Colors
  static const Color inputFill = Color(0xFFF8F8F8);
  static const Color inputBorder = Color(0xFFE0E0E0);
  static const Color inputFocusBorder = primaryNavy;

  // Icon Colors
  static const Color iconPrimary = Color(0xFF2D5F4F);
  static const Color iconSecondary = Color(0xFF757575);
  static const Color iconLight = Color(0xFFB0B0B0);

  static List<BoxShadow> get primaryButtonShadow => [
    BoxShadow(
      color: primaryNavy.withValues(alpha: 0.2),
      offset: const Offset(0, 10),
      blurRadius: 15,
      spreadRadius: -3,
    ),
    BoxShadow(
      color: primaryNavy.withValues(alpha: 0.2),
      offset: const Offset(0, 10),
      blurRadius: 15,
      spreadRadius: -4,
    ),
  ];
}