import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pjs_portal/features/settings/settings_sub_screens/widgets/developer_card.dart';

import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_text_styles.dart';

class AboutDevelopersScreen extends StatelessWidget {
  const AboutDevelopersScreen({super.key});

  static const _developers = [
    ('م.عيسى أبو سلمية', 'edu19982025@gmail.com', '+972 598 421 024'),
    ('م.لؤي العطار', 'lwyaltar1@gmail.com', '+972 592 956 053'),
    ('م.فاطمة كلاي', 'fatimaklay2002@gmail.com', '+972 592 370 473'),
    ('م.ديما أبو الجديان', 'dima.jd2004@gmail.com', '+970 597 599 839'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar:AppBar(
          leading:IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('عن المطورون')),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          SizedBox(height: 8.h),
          Text('فريق التطوير', style: AppTextStyles.headlineSmall, textAlign: TextAlign.center),
          SizedBox(height: 4.h),
          Text('تم تطوير هذا التطبيق بواسطة فريق متخصص',
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
              textAlign:TextAlign.center),
          SizedBox(height: 20.h),
          ..._developers.map((d) => Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: DeveloperCard(name: d.$1, email: d.$2, phone: d.$3),
          )),
          SizedBox(height: 12.h),
          Text('© 2026 نقابة الصحفيين. جميع الحقوق محفوظة.',
              style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}