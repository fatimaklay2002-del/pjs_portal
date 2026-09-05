import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/Constants/app_strings.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/service/export_service.dart';
import '../../../../members/data/model/member_model.dart';

class ExportButton extends StatelessWidget {
  final List<MemberModel> members;
  const ExportButton({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _exportMembers(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.primaryNavy.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.primaryNavy.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.download_outlined,
              color: AppColors.primaryNavy,
              size: 18.sp,
            ),
            SizedBox(width: 6.w),
            Text(
              AppStrings.downloadFile,
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.primaryNavy,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _exportMembers(BuildContext context) async {
    if (members.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لا يوجد أعضاء لتصدير بياناتهم')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('جاري تجهيز ملف الاكسل...'),
        duration: Duration(seconds: 1),
      ),
    );

    try {
      // 3. استدعاء خدمة التصدير
      final file = await MemberExportService.exportMembersToExcel(members);

      // 4. مشاركة الملف
      await MemberExportService.shareExportedFile(file);

    } catch (e) {
      // 5. معالجة الأخطاء في حال فشل التصدير
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('حدث خطأ أثناء التصدير: $e'),
            backgroundColor: AppColors.accentRed,
          ),
        );
      }
    }
  }
}
