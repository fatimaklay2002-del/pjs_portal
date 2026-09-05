import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/app_color.dart';
import '../../../../../../core/theme/app_text_styles.dart';



class AttachmentRow extends StatelessWidget {
  final String label;
  final String? existingUrl;
  final PlatformFile? newFile;
  final VoidCallback onTap;

  const AttachmentRow({super.key,
    required this.label,
    required this.existingUrl,
    required this.newFile,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasNew      = newFile != null;
    final hasExisting = existingUrl != null && existingUrl!.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: hasNew
              ? AppColors.primaryNavy.withValues(alpha: 0.05)
              : AppColors.background,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: hasNew
                ? AppColors.primaryNavy
                : AppColors.inputBorder,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: AppTextStyles.bodyMedium),
                    Text(
                      hasNew
                          ? newFile!.name
                          : hasExisting
                          ? 'مرفق ✓'
                          : 'اضغط للرفع',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: hasNew
                            ? AppColors.success
                            : hasExisting
                            ? AppColors.textSecondary
                            : AppColors.accentRed,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Icon(
              hasNew ? Icons.check_circle : Icons.edit_outlined,
              color: hasNew ? AppColors.success : AppColors.primaryNavy,
              size: 18.w,
            ),

          ],
        ),
      ),
    );
  }
}