import 'package:flutter/material.dart';

import '../../../../core/theme/app_color.dart';

class WelcomeLogoWidgets extends StatelessWidget {
  const WelcomeLogoWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 112,
      height: 112,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 112,
            height: 112,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
              border: Border.all(color: AppColors.divider),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryNavy.withValues(alpha: 0.08),
                  blurRadius: 35,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset('assets/images/logo.jpeg', fit: BoxFit.contain),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryNavy,
                border: Border.all(color: AppColors.white, width: 2),
              ),
              child: const Icon(Icons.image_outlined, size: 13, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}