
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_color.dart';
import '../theme/app_text_styles.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final Color? borderColor;
  final Color?textColor;
  final Color? backgroundColor;
  final bool isLoading;
  final IconData? icon;

  const CustomOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.borderColor=AppColors.textPrimary,
    this.textColor=AppColors.textPrimary,
    this.backgroundColor=AppColors.white,
    this.width = 110,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width?.w ?? double.infinity,
      height: 50.h,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          side:  BorderSide(
            color: borderColor!,
            width: 0.8.w,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(45.r),
          ),

          foregroundColor: AppColors.textPrimary,
          backgroundColor: backgroundColor,
        ),
        child: isLoading
            ? SizedBox(
          height: 20.h,
          width: 20.w,
          child: CircularProgressIndicator(
            strokeWidth: 2.w,
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2F2E41)),
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18.sp, color: textColor),
              SizedBox(width: 6.w),
            ],
            Flexible(
              child: Text(
                text,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}