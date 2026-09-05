import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/Constants/app_strings.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

class NewsImagePickerField extends StatelessWidget {
  final File? selectedImage;
  final String? existingImageUrl;
  final bool isEdit;
  final VoidCallback onTap;

  const NewsImagePickerField({
    super.key,
    required this.selectedImage,
    required this.existingImageUrl,
    required this.isEdit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = selectedImage != null || existingImageUrl != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: AppColors.black.withValues(alpha: 0.04), blurRadius: 3)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.lightNavy.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(Icons.image_outlined, color: AppColors.primaryNavy, size: 18),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStrings.newsImage, style: AppTextStyles.bodyMedium),
                    Text(
                      hasImage
                          ? (selectedImage?.path.split('/').last ?? 'صورة موجودة')
                          : 'لم يتم اختيار صورة',
                      style: AppTextStyles.labelSmall,
                    ),
                  ],
                ),
              ],
            ),
            Icon(isEdit ? Icons.edit_outlined : Icons.add_circle_outline,
                color: AppColors.primaryNavy, size: 18),
          ],
        ),
      ),
    );
  }
}