import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_styles.dart';

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        height: 33.h,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1 ,color: AppColors.divider.withValues(alpha: .5)),)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(color: AppColors.lightGrey),
                textAlign: TextAlign.right,
              ),
            ),
            Text(value, style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.info
            )),
          ],
        ),
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  final String title;
  final Widget icon;
  final Widget child;

  const SectionCard({super.key,
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            icon,
            SizedBox(width: 8.w),
            Text(
              title,
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.lightNavy,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow:[
              BoxShadow(
                blurRadius: 10,
                color: AppColors.black.withValues(alpha: 0.1),
                offset: Offset(0, 8),
                spreadRadius: -6,
              )
            ],
            border: Border.all(color: AppColors.divider, width: 1),
          ),
          child: child,

          ),

      ],
    );
  }
}
