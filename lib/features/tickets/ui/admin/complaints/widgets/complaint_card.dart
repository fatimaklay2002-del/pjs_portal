import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pjs_portal/features/tickets/data/model/ticket_model.dart';

import '../../../../../../core/theme/app_color.dart';
import '../../../../../../core/theme/app_text_styles.dart';

class ComplaintCard extends StatelessWidget {
  final TicketModel complaint;

  const ComplaintCard({super.key, required this.complaint});

  Color _statusColor() {
    switch (complaint.status) {
      case 'resolved': return AppColors.textSecondary;
      case 'under_processing': return AppColors.accentBlue;
      default: return AppColors.accentYellow;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'شكوى من : ',
                            style: AppTextStyles.labelMedium
                                .copyWith(color: AppColors.accentRed),
                          ),
                          TextSpan(
                            text: complaint.userName,
                            style: AppTextStyles.labelMedium
                                .copyWith(color: AppColors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '" ${complaint.description} "',
                      style: AppTextStyles.bodySmall,
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w, vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: _statusColor().withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  complaint.statusText,
                  style: AppTextStyles.labelSmall
                      .copyWith(color: _statusColor()),
                ),
              ),
            ],
          ),
        ),
    );
  }
}