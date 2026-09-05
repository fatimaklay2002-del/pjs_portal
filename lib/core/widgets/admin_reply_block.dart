import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_color.dart';
import '../theme/app_text_styles.dart';

class AdminReplyBlock extends StatelessWidget {
  final String response;
  const AdminReplyBlock({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
        border: Border(
          right: BorderSide(
            color: AppColors.primaryNavy,
            width: 4.w,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'رد الإدارة :',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.primaryNavy,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            response,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.primaryNavy,
            ),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
}