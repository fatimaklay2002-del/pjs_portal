import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pjs_portal/features/settings/settings_sub_screens/widgets/info_section_card.dart';

import '../../../core/theme/app_color.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      (Icons.description_outlined, AppColors.primaryNavy, 'جمع المعلومات',
      'نقوم بجمع المعلومات التي تقدمها لنا مباشرة عند التسجيل في التطبيق، مثل الاسم ورقم الهاتف والبريد الإلكتروني ورقم العضوية. هذه المعلومات ضرورية لتقديم خدماتنا لك.'),
      (Icons.help_outline, AppColors.accentBlue, 'استخدام المعلومات',
      'نستخدم معلوماتك لتوفير وتحسين خدماتنا، إرسال الإشعارات والتحديثات، معالجة الشكاوى والاستفسارات، والتواصل معك بشأن أنشطة النقابة.'),
      (Icons.shield_outlined, AppColors.accentYellow, 'حماية المعلومات',
      'نحن نتخذ إجراءات أمنية مناسبة لحماية معلوماتك من الوصول غير المصرح به أو التغيير أو الإفصاح أو الإتلاف. نستخدم تشفير SSL لحماية البيانات أثناء النقل.'),
      (Icons.settings_outlined, AppColors.accentRed, 'حقوقك',
      'لديك الحق في الوصول إلى بياناتك الشخصية وتصحيحها أو حذفها. يمكنك أيضاً طلب نسخة من بياناتك أو الاعتراض على معالجتها في أي وقت.'),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading:IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded), // شكل الأيقونة الذي تفضلينه
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("سياسة الخصوصية"),),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: sections.map((s) => Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: InfoSectionCard(icon: s.$1, iconColor: s.$2, title: s.$3, content: s.$4),
        )).toList(),
      ),
    );
  }
}