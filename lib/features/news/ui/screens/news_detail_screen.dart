import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pjs_portal/features/news/ui/widgets/admin_build_icon_button.dart';

import '../../../../core/dialogs/delete_news_dialog.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../data/model/news_model.dart';
import '../../logic/news_cubit.dart';
import '../widgets/news_action_link_button.dart';
import 'add_update_news.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsModel news;
  final bool isAdmin;

  const NewsDetailScreen({super.key, required this.news, this.isAdmin = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // 1. الصورة في الخلفية
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 418.h,
            child: news.imageUrl != null
                ? Image.network(news.imageUrl!, fit: BoxFit.cover)
                : _imagePlaceholder(),
          ),
          Positioned(
            top: 270.h,
            right: 20.w,
            left: 20.w,
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // التاريخ والتصنيف
                Text(
                  DateFormatter.toArabic(news.createdAt),
                  style: TextStyle(color: Colors.white70),
                ),

                SizedBox(height: 6.h),
                // العنوان
                Text(
                  news.title,
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),

          // 2. المحتوى الأبيض (التداخل)
          Positioned(
            top: 360.h, // نقطة البداية لتغطية الصورة
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              padding: EdgeInsets.all(20.w),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: 100.h,
                ), // مساحة للأزرار في الأسفل
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.content,
                      style: AppTextStyles.bodyLarge.copyWith(height: 1.8),
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                    ),
                    if (news.hasActionLink) ...[
                      SizedBox(height: 16.h),
                      NewsActionLinkButton(
                        url: news.actionLink!,
                        label: news.actionLinkLabel?.isNotEmpty == true
                            ? news.actionLinkLabel!
                            : 'رابط التسجيل',
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),

          // 3. أزرار الأدمن (مثبتة أسفل الجزء الأبيض)
          if (isAdmin)
            Positioned(
              bottom: 20.h,
              left: 20.w,
              right: 20.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AdminBuildIconButton(
                    icon: Icons.delete,
                    color: AppColors.accentRed,
                    onPressed: () async {
                      final confirmed = await showDeleteNewsDialog(context);
                      if (confirmed == true && context.mounted) {
                        context.read<NewsCubit>().deleteNews(news.id);
                        Navigator.of(context).pop(); // go back after delete
                      }
                    },
                  ),
                  SizedBox(width: 10.w),
                  AdminBuildIconButton(
                    icon: Icons.edit,
                    color: AppColors.accentBlue,
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => NewsAddEditScreen(news: news),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // 4. زر العودة
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 16,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.chevron_left,
                    color: AppColors.white,
                    size: 18.w,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  'عودة',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      color: AppColors.lightNavy,
      child: Center(
        child: Icon(
          Icons.image_outlined,
          color: AppColors.primaryNavy,
          size: 64,
        ),
      ),
    );
  }
}
