import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pjs_portal/features/settings/settings_sub_screens/widgets/info_section_card.dart';

import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_text_styles.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading:IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded), // شكل الأيقونة الذي تفضلينه
          onPressed: () => Navigator.of(context).pop(),
        ),
          title: Text('الأحكام والشروط')),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          InfoSectionCard(
            title: 'مقدمة',
            content: 'باستخدامك لهذا التطبيق، فإنك توافق على الالتزام بهذه الأحكام والشروط. يرجى قراءتها بعناية قبل استخدام التطبيق.',
          ),
          SizedBox(height: 12.h),
          InfoSectionCard(
            icon: Icons.check_circle_outline,
            iconColor: AppColors.success,
            title: 'الاستخدام المسموح',
            contentList: [
              'الوصول إلى أخبار وإعلانات النقابة',
              'تقديم الشكاوى والاستفسارات',
              'تحديث البيانات الشخصية',
              'التواصل مع إدارة النقابة',
            ],
          ),
          SizedBox(height: 12.h),
          InfoSectionCard(
            icon: Icons.cancel_outlined,
            iconColor: AppColors.accentRed,
            title: 'الاستخدام المحظور',
            contentList: [
              'انتحال شخصية الآخرين',
              'نشر محتوى مسيء أو غير لائق',
              'محاولة اختراق النظام',
              'استخدام التطبيق لأغراض غير مشروعة',
            ],
          ),
          SizedBox(height: 12.h),
          InfoSectionCard(
            icon: Icons.lock_outline,
            iconColor: AppColors.accentBlue,
            title: 'حقوق الملكية',
            content: 'جميع المحتويات والتصاميم والعلامات التجارية في هذا التطبيق هي ملك لنقابة الصحفيين. لا يجوز نسخها أو توزيعها دون إذن كتابي مسبق.',
          ),
          SizedBox(height: 12.h),
          InfoSectionCard(
            icon: Icons.warning_amber_outlined,
            iconColor: AppColors.accentYellow,
            title: 'إخلاء المسؤولية',
            content: 'نحن نسعى لتوفير معلومات دقيقة ومحدثة، لكننا لا نضمن خلو المحتوى من الأخطاء. النقابة غير مسؤولة عن أي أضرار ناتجة عن استخدام التطبيق.',
          ),
          SizedBox(height: 12.h),

          // Agreement box
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'باستخدامك للتطبيق فإنك توافق على جميع الأحكام والشروط المذكورة أعلاه',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primaryNavy),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}