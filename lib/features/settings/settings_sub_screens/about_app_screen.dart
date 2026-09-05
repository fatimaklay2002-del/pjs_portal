import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pjs_portal/features/settings/settings_sub_screens/widgets/info_card.dart';

import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_text_styles.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading:IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
       title: Text("عن التطبيق"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            SizedBox(height: 8.h),
            // Logo
            Container(
              width: 80.w,
              height: 80.w,
              decoration: const BoxDecoration(
                color: AppColors.lightNavy,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/logo.jpeg',
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Icon(
                    Icons.verified,
                    color: AppColors.primaryNavy,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text('نقابة الصحافة', style: AppTextStyles.headlineSmall),
            SizedBox(height: 4.h),
            Text('الإصدار 1.0.0',
                style: AppTextStyles.bodySmall
                    .copyWith(color: AppColors.textSecondary)),
            SizedBox(height: 24.h),

            // About card
            InfoCard(
              title: 'عن التطبيق',
              content:
              'تطبيق نقابة الصحفيين هو منصة متكاملة لإدارة شؤون أعضاء النقابة. يوفر التطبيق إمكانية متابعة الأخبار والإعلانات، تقديم الشكاوى والاستفسارات، والتواصل مع إدارة النقابة بشكل مباشر.',
            ),
            SizedBox(height: 12.h),

            // Features card
            _FeaturesCard(),
            SizedBox(height: 24.h),

            Text(
              '© 2026 نقابة الصحفيين. جميع الحقوق محفوظة.',
              style: AppTextStyles.labelSmall
                  .copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}

class _FeaturesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final features = [
      (Icons.bookmark_outline, AppColors.primaryNavy, 'متابعة الأخبار', 'آخر أخبار وفعاليات النقابة'),
      (Icons.chat_bubble_outline, AppColors.accentBlue, 'تقديم الشكاوى', 'إرسال الشكاوى والاستفسارات'),
      (Icons.notifications_outlined, AppColors.accentYellow, 'الإشعارات الفورية', 'تنبيهات فورية بالمستجدات'),
    ];

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: AppColors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('مميزات التطبيق', style: AppTextStyles.titleSmall),
          SizedBox(height: 12.h),
          ...features.map((f) => Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: f.$2.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(f.$1, color: f.$2, size: 20.w),
                ),
                SizedBox(width: 12.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(f.$3, style: AppTextStyles.labelMedium),
                      Text(f.$4, style: AppTextStyles.bodySmall),
                    ],
                  ),
                ),


              ],
            ),
          )),
        ],
      ),
    );
  }
}