import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/Constants/app_strings.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: TextButton.icon(
            onPressed: () => context.pop(),
            icon: Icon(Icons.arrow_back_ios,
                color: AppColors.primaryNavy, size: 16.sp),
            label: Text(AppStrings.back,
                style: TextStyle(color: AppColors.primaryNavy)),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          width: 64.w,
          height: 64.w,
          decoration: BoxDecoration(
            color: AppColors.primaryNavy.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(Icons.login_rounded,
              color: AppColors.primaryNavy, size: 32.sp),
        ),
        SizedBox(height: 24.h),
        Text(
          'تسجيل الدخول',
          style: AppTextStyles.headlineMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        Text(
          'أدخل بيانات الاعتماد للمتابعة',
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}