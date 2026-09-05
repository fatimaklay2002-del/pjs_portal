
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_color.dart';

class AppTextStyles {
  AppTextStyles._();

  // Display styles
  static final TextStyle displayLarge = TextStyle(
    fontFamily: 'IBM Plex Sans',
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2.h,
  );

  static final TextStyle displayMedium = TextStyle(
    fontFamily: 'IBM Plex Sans',
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2.h,
  );

  static final TextStyle displaySmall = TextStyle(
    fontFamily: 'IBM Plex Sans',
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2.h,
  );

  // Headline styles
  static final TextStyle headlineLarge = TextStyle(
    fontFamily: 'IBM Plex Sans',
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.3.h,
  );

  static final TextStyle headlineMedium = TextStyle(
    fontFamily: 'IBM Plex Sans',
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3.h,
  );

  static final TextStyle headlineSmall = TextStyle(
    fontFamily: 'IBM Plex Sans',
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3.h,
  );

  // Title styles
  static final TextStyle titleLarge = TextStyle(
    fontFamily: 'IBM Plex Sans',
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4.h,
  );

  static final TextStyle titleMedium = TextStyle(
    fontFamily: 'IBM Plex Sans',
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4.h,
  );

  static final TextStyle titleSmall = TextStyle(
    fontFamily: 'IBM Plex Sans',
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4.h,
  );

  // Body styles
  static final TextStyle bodyLarge = TextStyle(
    fontFamily: 'IBM Plex Sans',
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.5.h,

  );

  static final TextStyle bodyMedium = TextStyle(
    fontFamily: 'IBM Plex Sans',
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5.h,
  );

  static final TextStyle bodySmall = TextStyle(
    fontFamily: 'IBM Plex Sans',
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5.h,
  );

  // Label styles
  static final TextStyle labelLarge = TextStyle(
    fontFamily: 'IBM Plex Sans',
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4.h,
  );

  static final TextStyle labelMedium = TextStyle(
    fontFamily: 'IBM Plex Sans',
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4.h,
  );

  static final TextStyle labelSmall = TextStyle(
    fontFamily: 'IBM Plex Sans',
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.4.h,
  );

  // Button styles
  static final TextStyle button = TextStyle(
    fontFamily: 'IBM Plex Sans',
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    height: 1.2.h,
  );

  // Caption/Hint styles
  static final TextStyle caption = TextStyle(
    fontFamily: 'IBM Plex Sans',
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.3,
  );

  static final TextStyle hint = TextStyle(
    fontFamily: 'IBM Plex Sans',
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textHint,
    height: 1.3,
  );
}
