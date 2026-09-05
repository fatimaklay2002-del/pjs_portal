import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

class InfoSectionCard extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final String title;
  final String? content;
  final List<String>? contentList;

  const InfoSectionCard({super.key, this.icon, this.iconColor, required this.title, this.content, this.contentList});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: AppColors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (icon != null) ...[
                Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: (iconColor ?? AppColors.primaryNavy).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor ?? AppColors.primaryNavy, size: 18.w),
                ),
              ],
              SizedBox(width: 8),
              Text(title, style: AppTextStyles.titleMedium),

            ],
          ),
          SizedBox(height: 10.h),
          if (content != null)
            Text(content!, style: AppTextStyles.bodyMedium, textAlign: TextAlign.right, textDirection: TextDirection.rtl),
          if (contentList != null)
            ...contentList!.map((item) => Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(width: 5.w, height: 5.w, decoration: BoxDecoration(color: AppColors.primaryNavy, shape: BoxShape.circle)),
                  SizedBox(width: 8.w),
                  Text(item, style: AppTextStyles.bodyMedium, textAlign: TextAlign.right),
                ],
              ),
            )),
        ],
      ),
    );
  }
}
