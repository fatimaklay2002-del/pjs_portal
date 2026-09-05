import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/app_color.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/widgets/admin_reply_block.dart';
import '../../../../data/model/ticket_model.dart';

class InquiryCard extends StatelessWidget {
  final TicketModel inquiry;
  final String date;

  const InquiryCard({super.key, required this.inquiry, required this.date});

  Color get _statusColor {
    if (inquiry.isReplied) return AppColors.primaryNavy;
    return inquiry.status == 'under_processing' ? AppColors.accentBlue : AppColors.accentRed;
  }

  String get _statusText => inquiry.isReplied ? 'تم الرد' : inquiry.statusText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date, style: AppTextStyles.labelSmall),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(_statusText, style: AppTextStyles.labelSmall.copyWith(color: _statusColor)),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            '" ${inquiry.description} "',
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
          SizedBox(height: 10.h),
          if (inquiry.isReplied && inquiry.adminReply != null) ...[
            AdminReplyBlock(response: inquiry.adminReply!),
          ],
        ],
      ),
    );
  }
}
