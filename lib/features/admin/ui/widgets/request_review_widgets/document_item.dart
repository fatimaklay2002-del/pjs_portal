import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/file_helper.dart';

class DocumentItem extends StatelessWidget {
  final String label;
  final String url;
  const DocumentItem({super.key,required this.label,required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
                color: AppColors.black.withValues(alpha: 0.1),
                blurRadius: 2,
                spreadRadius: -1,
                offset: Offset(0, 1)),
            BoxShadow(
                color: AppColors.black.withValues(alpha: 0.1),
                blurRadius: 3,
                offset: Offset(0, 1))
          ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label & filename
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.bodyMedium),
                Text(
                    FileHelper.getFileName(url),
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed:() async {
              if (!context.mounted) return;
              await FileHelper.previewFile(context, url);
            },
            icon: Icon(Icons.visibility_outlined, color: AppColors.primaryNavy),
            iconSize: 20.sp,
          ),
        ],
      ),
    );
  }

}
