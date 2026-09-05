import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String body;
  final String timeAgo;
  final bool isRead;
  final VoidCallback? onTap;

  const NotificationCard({super.key,
    required this.title,
    required this.body,
    required this.timeAgo,
    required this.isRead,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          border: Border.all(color:isRead ? Colors.transparent : AppColors.primaryNavy, width: 1 ),
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Content on the right
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(title, style: AppTextStyles.titleSmall),
                      SizedBox(width: 6.w),
                      // Unread dot
                      Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          color: isRead
                              ? Colors.grey
                              : AppColors.primaryNavy,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    body,
                    style: AppTextStyles.bodySmall,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
            // Time on the left
            Text(timeAgo, style: AppTextStyles.labelSmall),
          ],
        ),
      ),
    );
  }
}
