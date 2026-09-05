import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isRed;
  final bool showDivider;

  const SettingsItem({super.key, required this.icon, required this.label, required this.onTap, this.isRed = false, this.showDivider = true});

  @override
  Widget build(BuildContext context) {
    final color = isRed ? AppColors.accentRed : AppColors.textPrimary;
    final iconColor = isRed ? AppColors.accentRed : AppColors.iconPrimary;
    return Column(
      children: [

        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Row(
              children: [
                Icon(icon, color: iconColor, size: 20.w),
                SizedBox(width: 12.w),
                Text(label, style: AppTextStyles.bodyMedium.copyWith(color: color)),

                const Spacer(),
                Icon(Icons.chevron_right, color: AppColors.iconSecondary, size: 20.w),


              ],
            ),
          ),
        ),

        if (showDivider) Divider(height: 1, thickness: 1, color: AppColors.divider, indent: 16.w, endIndent: 16.w),
      ],
    );
  }
}