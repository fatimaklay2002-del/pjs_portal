import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_color.dart';
import '../theme/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double width;
  final IconData? icon;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.width=200,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width.w ,
        height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45.r),
        boxShadow: AppColors.primaryButtonShadow,
      ),
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppColors.primaryNavy,
            foregroundColor: textColor ?? AppColors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(45.r),

            ),
            disabledBackgroundColor: AppColors.primaryNavy.withValues(alpha: 0.6),
          ),
          child: isLoading
              ? SizedBox(
            height: 24.h,
            width: 24.w,
            child: CircularProgressIndicator(
              strokeWidth: 2.5.w,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
            ),
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20.sp, color: textColor ?? AppColors.white),
                SizedBox(width: 8.w),
              ],
              Text(text, style: AppTextStyles.button),
            ],
          ),
        ),
    );
  }
}