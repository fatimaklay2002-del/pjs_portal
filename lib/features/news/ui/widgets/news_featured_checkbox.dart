import 'package:flutter/material.dart';

import '../../../../core/Constants/app_strings.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

class NewsFeaturedCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const NewsFeaturedCheckbox({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: value ? AppColors.textPrimary : AppColors.inputBorder),
              color: value ? AppColors.primaryNavy : Colors.transparent,
            ),
            child: value ? const Icon(Icons.check, color: Colors.white, size: 14) : null,
          ),
          const SizedBox(width: 10),
          Text(AppStrings.featuredNews, style: AppTextStyles.bodyLarge),
        ],
      ),
    );
  }
}