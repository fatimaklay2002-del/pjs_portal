import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/navigation_extensions.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../data/model/news_model.dart';

import '../../logic/news_cubit.dart';
import '../screens/news_detail_screen.dart';
import 'admin_build_icon_button.dart';

class NewsCard extends StatelessWidget {
  final NewsModel news;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool isAdmin;

  const NewsCard({
    super.key,
    required this.news,
    this.onEdit,
    this.onDelete,
    this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> context.pushWithCubit(
            context.read<NewsCubit>(),
            NewsDetailScreen(news: news, isAdmin: isAdmin),
         ),
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 0.8),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.1),
              offset: const Offset(0, 1),
              blurRadius: 3,
            ),
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.1),
              offset: const Offset(0, 1),
              blurRadius: 2,
              spreadRadius: -1,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (news.imageUrl != null && news.imageUrl!.isNotEmpty) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.network(
                    news.imageUrl!,
                    width: 100.w,
                    height: 100.h,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 12.w),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildCategoryBadge(news.category),
                        SizedBox(width: 8.w),
                        Text(
                          DateFormatter.toArabic(news.createdAt),
                          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                        ),
                        const Spacer(),
                        if (isAdmin) ...[
                          AdminBuildIconButton(icon: Icons.edit, color: AppColors.accentBlue, onPressed: onEdit),
                          SizedBox(width: 8.w),
                          AdminBuildIconButton(icon: Icons.delete, color: AppColors.accentRed, onPressed: onDelete),
                        ],
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      news.title,
                      style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      news.content,
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                      maxLines: news.imageUrl != null ? 2 : 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (news.hasActionLink) ...[
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Icon(Icons.link_rounded, size: 14.w, color: AppColors.primaryNavy),
                          SizedBox(width: 4.w),
                          Text(
                            news.actionLinkLabel?.isNotEmpty == true
                                ? news.actionLinkLabel!
                                : 'يحتوي رابط',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.primaryNavy,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryBadge(String category) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppColors.primaryNavy.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        category,
        style: AppTextStyles.bodySmall.copyWith(color: AppColors.primaryNavy),
      ),
    );
  }
}