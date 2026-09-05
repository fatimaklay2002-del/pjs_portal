import 'package:flutter/material.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

class NewsEmptyState extends StatelessWidget {
  const NewsEmptyState({super.key});
  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.article_outlined, size: 64, color: AppColors.iconSecondary),
        const SizedBox(height: 12),
        Text('لا توجد أخبار', style: AppTextStyles.bodyMedium),
      ],
    ),
  );
}

class NewsErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const NewsErrorState({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline, size: 48, color: AppColors.accentRed),
        const SizedBox(height: 12),
        Text(message, style: AppTextStyles.bodyMedium),
        const SizedBox(height: 16),
        ElevatedButton(onPressed: onRetry, child: const Text('إعادة المحاولة')),
      ],
    ),
  );
}