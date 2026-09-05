
import 'package:flutter/material.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

class NewsCategoryDropdown extends StatelessWidget {
  final String value;
  final List<String> categories;
  final ValueChanged<String> onChanged;

  const NewsCategoryDropdown({
    super.key,
    required this.value,
    required this.categories,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: AppColors.black.withValues(alpha: 0.05), blurRadius: 4)],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          alignment: Alignment.centerRight,
          borderRadius: BorderRadius.circular(16),
          elevation: 3,
          dropdownColor: AppColors.white,
          icon: const Icon(Icons.keyboard_arrow_down),
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
          items: categories
              .map((c) => DropdownMenuItem(
            value: c,
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(c, textDirection: TextDirection.rtl),
            ),
          ))
              .toList(),
          onChanged: (v) => v != null ? onChanged(v) : null,
        ),
      ),
    );
  }
}