import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  /// Convenience factory – shows the dialog and awaits dismissal.
  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const SuccessDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r)),
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.lock_person_outlined,
                size: 80.sp,
                color: AppColors.primaryNavy.withValues(alpha: 0.5),
              ),
              SizedBox(height: 24.h),
              Text(
                'تم تقديم الطلب بنجاح',
                style: AppTextStyles.headlineSmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              Text(
                'ترقب بريدك الالكتروني للحصول على بيانات '
                    'تسجيل الدخول بعد قبول طلبك',
                style:
                AppTextStyles.bodyMedium.copyWith(color: AppColors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),
              PrimaryButton(
                text: 'عودة',
                width: 200.w,
                backgroundColor: AppColors.primaryNavy,
                onPressed: () {
                  Navigator.pop(context); // close dialog
                  Navigator.pop(context); // return to previous route
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
