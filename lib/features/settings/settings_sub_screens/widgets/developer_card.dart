import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pjs_portal/core/Constants/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

class DeveloperCard extends StatelessWidget {
  final String name;
  final String email;
  final String phone;

  const DeveloperCard({super.key,
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> launchEmail() async {
      final uri = Uri(scheme: 'mailto', path: email);
      if (await canLaunchUrl(uri)) await launchUrl(uri);
    }

    Future<void> launchWhatsApp() async {
      final cleaned = phone.replaceAll(RegExp(r'\D'), '');
      final uri = Uri.parse('https://wa.me/$cleaned');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.titleSmall),
                TextButton(
                  onPressed: launchEmail,
                  child: Text(AppStrings.email, style: AppTextStyles.bodySmall),
                ),
              ],
            ),
          ),
          // WhatsApp button
          GestureDetector(
            onTap: launchWhatsApp,
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF25D366),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/whatsapp_icon.svg',
                  width: 20.w,
                  height: 20.h,
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
