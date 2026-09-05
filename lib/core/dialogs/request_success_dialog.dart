import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../theme/app_color.dart';
import '../widgets/primary_button.dart'; // تأكدي من مسار زر الـ PrimaryButton

Future<void> showRequestSuccessDialog(BuildContext context, {required VoidCallback onConfirm}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, size: 64.sp, color: AppColors.success),
              SizedBox(height: 16.h),
              Text(
                AppStrings.requestApprovedSuccessfully,
                style: AppTextStyles.headlineSmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                AppStrings.emailSentToMember,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              PrimaryButton(
                text: AppStrings.ok,
                onPressed: onConfirm,
                width: 150.w,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}