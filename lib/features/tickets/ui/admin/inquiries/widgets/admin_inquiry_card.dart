import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pjs_portal/core/widgets/primary_button.dart';
import 'package:pjs_portal/features/tickets/ui/admin/inquiries/widgets/reply_dialog.dart';

import '../../../../../../core/theme/app_color.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/widgets/admin_reply_block.dart';
import '../../../../data/model/ticket_model.dart';
import '../../../../logic/admin/admin_tickets_cubit.dart';

class AdminInquiryCard extends StatelessWidget {
  final TicketModel inquiry;
  final String date;

  const AdminInquiryCard({super.key, required this.inquiry, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: AppColors.black.withValues(alpha: 0.1), blurRadius: 25, spreadRadius: -5, offset: Offset(0, 20)),
          BoxShadow(color: AppColors.black.withValues(alpha: 0.1), blurRadius: 10, spreadRadius: -6, offset: Offset(0, 8)),
        ],
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(date, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: inquiry.isReplied
                        ? AppColors.textSecondary.withValues(alpha: 0.05)
                        : AppColors.accentYellow.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    inquiry.isReplied ? 'تم الرد' : 'بالانتظار',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: inquiry.isReplied ? AppColors.textSecondary : AppColors.accentYellow,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(inquiry.userName ?? 'غير محدد', style: AppTextStyles.labelMedium),
            SizedBox(height: 10.h),
            Text('" ${inquiry.description} "', style: AppTextStyles.bodyLarge, textDirection: TextDirection.rtl),
            SizedBox(height: 12.h),
            if (inquiry.isReplied && inquiry.adminReply != null) ...[
              AdminReplyBlock(response: inquiry.adminReply!),
            ],
            SizedBox(height: 30.h),
            if (!inquiry.isReplied) ...[
              Center(
                child: PrimaryButton(
                  text: "الرد على الرسالة",
                  onPressed: () => showDialog(
                    barrierColor: Colors.black.withValues(alpha: 0.7),
                    context: context,
                    builder: (_) => BlocProvider.value(
                      value: context.read<AdminTicketsCubit>(),
                      child: ReplyDialog(inquiry: inquiry),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

