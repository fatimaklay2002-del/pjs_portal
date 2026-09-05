import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

class AttachmentItem extends StatelessWidget {
  final String label;
  final PlatformFile? file;
  final VoidCallback onTap;
  final bool isRequired;

  const AttachmentItem({
    super.key,
    required this.label,
    required this.file,
    required this.onTap,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasFile = file != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: hasFile
              ? AppColors.primaryNavy.withValues(alpha: 0.03)
              : const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: hasFile ? AppColors.primaryNavy : const Color(0xFFE2E8F0),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: AppColors.black.withValues(alpha: 0.05),
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              label,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: hasFile
                                    ? AppColors.primaryNavy
                                    : Colors.grey,
                                fontWeight: hasFile
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                            if (isRequired) ...[
                              Text(
                                '*',
                                style: TextStyle(
                                  color: AppColors.accentRed,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (hasFile) ...[
                    SizedBox(height: 4.h),
                    Text(
                      file!.name,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.right,
                    ),
                  ],
                ],
              ),
            ),
            // ── Upload / check icon ──────────────────────────────────────
            hasFile
                ? Icon(
              Icons.check_circle,
              color: AppColors.success,
              size: 24.sp,
            )
                : SvgPicture.asset(
              "assets/icons/upload_icon.svg",
              width: 24.sp,
              height: 24.sp,
              colorFilter: ColorFilter.mode(AppColors.iconSecondary,BlendMode.srcIn,),
            ),

            SizedBox(width: 12.w),

            // ── Label + optional file name ───────────────────────────────

          ],
        ),
      ),
    );
  }
}