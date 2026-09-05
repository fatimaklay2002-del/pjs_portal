import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final String hint;
  final Widget? icon;
  final List<String> items;
  final String? value;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.hint,
    this.icon,
    required this.items,
    required this.onChanged,
    this.value,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          label,
          style: AppTextStyles.labelLarge,
        ),
         SizedBox(height: 8.h),

        // Dropdown
        DropdownButtonFormField<String>(
          alignment: AlignmentDirectional.centerStart,
          initialValue: value,
          hint: Text(
            hint,
            style: AppTextStyles.hint,
          ),
          decoration: InputDecoration(
            filled: true,
            prefixIcon: icon != null
                ? Padding(
              padding: EdgeInsets.all(12.w),
                child: icon,)
                : null,
            fillColor: AppColors.inputFill,
            contentPadding:  EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:  BorderSide(
                color: AppColors.inputBorder,
                width: 1.w,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:  BorderSide(
                color: AppColors.inputBorder,
                width: 1.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:  BorderSide(
                color: AppColors.primaryNavy,
                width: 2.w,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:  BorderSide(
                color: AppColors.accentRed,
                width: 1.w,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:  BorderSide(
                color: AppColors.accentRed,
                width: 2.w,
              ),
            ),
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                item,
                style: AppTextStyles.bodyMedium,
                textAlign: TextAlign.right,
              ),
            );
          }).toList(),
          onChanged: onChanged,
          validator: validator,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.iconSecondary,
          ),
          dropdownColor: AppColors.white,
        ),
      ],
    );
  }
}
