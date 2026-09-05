import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pjs_portal/core/widgets/primary_button.dart';

import '../../../../../../core/theme/app_color.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../data/model/ticket_model.dart';
import '../../../../logic/admin/admin_tickets_cubit.dart';

class ReplyDialog extends StatefulWidget {
  final TicketModel inquiry;

  const ReplyDialog({super.key, required this.inquiry});

  @override
  State<ReplyDialog> createState() => _ReplyDialogState();
}

class _ReplyDialogState extends State<ReplyDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    final replyText = _controller.text.trim();
    if (_controller.text.trim().isEmpty) return;
    context.read<AdminTicketsCubit>().replyToInquiry(
      inquiryId: widget.inquiry.id,
      response: replyText
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('الرد على استفسار', style: AppTextStyles.headlineSmall),
            SizedBox(height: 12.h),
            Text(
              '" ${widget.inquiry.description} "',
              style: AppTextStyles.bodyLarge
                  .copyWith(color: AppColors.textSecondary,fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
            SizedBox(height: 16.h),
            Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _controller,
                maxLines: 5,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                style: AppTextStyles.bodyMedium,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(12.w),
                ),
              ),
            ),
            SizedBox(height: 16.h),
           PrimaryButton(text: "إرسال الرد", onPressed: _send)
          ],
        ),
      ),
    );
  }
}