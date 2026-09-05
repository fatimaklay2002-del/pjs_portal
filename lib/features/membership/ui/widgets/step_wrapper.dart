import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/Constants/app_strings.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_outlined_button.dart';
import '../../../../core/widgets/primary_button.dart';

class StepWrapper extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Widget child;
  final String? subtitle;
  final VoidCallback? onBackAction; // لزر "عودة" العلوي
  final VoidCallback? onNextArrow;  // للسهم السفلي
  final VoidCallback? onPreviousArrow;
  final bool showArrows;

  const StepWrapper({
    super.key,
     this.title,
    this.icon,
    required this.child,
    this.subtitle,
    this.onBackAction,
    this.onNextArrow,
    this.onPreviousArrow,
    this.showArrows = true,
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        padding: EdgeInsets.symmetric(horizontal: 32.h,vertical: 26.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color:  AppColors.white),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 25,
              offset: const Offset(0, 20),
              spreadRadius: -5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. زر العودة العلوي (مكرر في كل الشاشات)
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: onBackAction ?? () => Navigator.pop(context),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back_ios, size: 14.sp, color: AppColors.primaryNavy),
                    Text('عودة', style: AppTextStyles.bodySmall.copyWith(color: AppColors.primaryNavy)),

                  ],
                ),
              ),
            ),

            // 2. المحتوى الرئيسي (الأيقونة والعناوين)
            if (icon != null) ...[
              SizedBox(height: 40.h),
              Center(
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: const BoxDecoration(color: Color(0xFFF1F5F9), shape: BoxShape.circle),
                  child: Icon(icon, color: AppColors.primaryNavy, size: 28.sp),
                ),
              ),
            ],
            if (title != null) ...[
              SizedBox(height: 16.h),
              Text(title!, style: AppTextStyles.headlineLarge, textAlign: TextAlign.center),
            ],
            if (subtitle != null) Text(subtitle!, style: AppTextStyles.bodySmall, textAlign: TextAlign.center),

             SizedBox(height: 42.h,),
            // 3. الحقول (الـ Child)
            child,

            // 4. أسهم التنقل السفلية (داخل الـ Wrapper)
            if (showArrows) ...[
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomOutlinedButton(
                    text: AppStrings.back,
                    onPressed: onPreviousArrow ?? () {},
                    borderColor: AppColors.primaryNavy,
                    textColor: AppColors.primaryNavy,
                    width: 100, // ✅ مباشرة هنا
                  ),
                  SizedBox(width: 12.w),
                  PrimaryButton(
                    text: AppStrings.next,
                    onPressed: onNextArrow,
                    width: 100, // ✅ مباشرة هنا
                  ),
                ],
              ),
            ],
          ],
        ),
      );
  }
}