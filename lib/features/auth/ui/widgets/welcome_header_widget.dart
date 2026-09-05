import 'package:flutter/material.dart';
import 'package:pjs_portal/core/Constants/app_strings.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

class WelcomeHeaderWidget extends StatelessWidget {
  const WelcomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.welcomeTitle,
          textAlign: TextAlign.center,
          style: AppTextStyles.displaySmall.copyWith(color: AppColors.primaryNavy),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            AppStrings.welcomeSubtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
          ),
        ),
      ],
    );
  }
}