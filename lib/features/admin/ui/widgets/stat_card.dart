import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Widget icon;
  final Color backgroundColor;
  final Color textColor;
  final Color valueColor;
  final VoidCallback onTap;
  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.backgroundColor = AppColors.primaryNavy,
    this.textColor = AppColors.white,
    this.valueColor=AppColors.white ,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        width: 170.w,
        constraints: BoxConstraints(minHeight:120.h ),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider, width: 0.8),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.1),
              offset: Offset(0, 1),
              blurRadius: 3,
              spreadRadius: 0,
            ),BoxShadow(
              color: AppColors.black.withValues(alpha: 0.1),
              offset: Offset(0, 1),
              blurRadius: 2,
              spreadRadius: -1,
            )
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 28.h,
              width: 28.h,
              decoration: BoxDecoration(
                color: valueColor.withValues(alpha: .2),
                borderRadius: BorderRadius.circular(8)
              ),
              child:FittedBox(
                fit: BoxFit.scaleDown,
                child: SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: icon,
                ),
              ),
            ),
            SizedBox(height: 12.h,),
            Text(
              title,
              style: AppTextStyles.bodyLarge.copyWith(
                color: textColor,

              ),
            ),
            Text(
              value,
              style: AppTextStyles.headlineMedium.copyWith(
                color: valueColor,

              ),
            ),
          ]

        ),

      ),
    );
  }
}
