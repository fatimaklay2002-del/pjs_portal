import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pjs_portal/core/extensions/context_extensions.dart';
import 'package:pjs_portal/core/widgets/primary_button.dart';

import '../../../../../../core/Constants/app_strings.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../../logic/members/member_tickets_cubit.dart';
import '../../../../logic/members/member_tickets_state.dart';

class NewInquiryTab extends StatefulWidget {
  const NewInquiryTab({super.key});

  @override
  State<NewInquiryTab> createState() => _NewInquiryTabState();
}

class _NewInquiryTabState extends State<NewInquiryTab> {
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_subjectController.text.trim().isEmpty ||
        _messageController.text.trim().isEmpty) {
      context.showErrorSnackBar(AppStrings.fillAllFields);
      return;
    }
    context.read<TicketsCubit>().sendInquiry(
      subject: _subjectController.text.trim(),
      message: _messageController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TicketsCubit, TicketsState>(
      listener: (context, state) {
        if (state is TicketsActionSuccess && state.type == TicketType.inquiry) {
          context.showSuccessSnackBar(state.message);
          _subjectController.clear();
          _messageController.clear();

        }
        if (state is TicketsError) {
          context.showErrorSnackBar(state.message);
        }
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),

            // Header
            Text(
              AppStrings.haveQuestion,
              style: AppTextStyles.headlineSmall,
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 4.h),
            Text(
             AppStrings.inquirySubTitle,
              style: AppTextStyles.bodySmall,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
            SizedBox(height: 24.h),

            // Subject
            Text(AppStrings.inquirySubject, style: AppTextStyles.titleSmall),
            SizedBox(height: 8.h),
            CustomTextField(
              controller: _subjectController,
              hint: AppStrings.inquirySubjectHint,
              maxLines: 1,
            ),
            SizedBox(height: 16.h),

            // Message
            Text(AppStrings.message, style: AppTextStyles.titleSmall),
            SizedBox(height: 8.h),
            CustomTextField(
              controller: _messageController,
              hint: AppStrings.inquiryMessageHint,
              maxLines: 6,
            ),
            SizedBox(height: 32.h),

            // Submit
            BlocBuilder<TicketsCubit, TicketsState>(
              builder: (context, state) {
                return Center(
                  child: PrimaryButton(
                    text: AppStrings.send,
                    isLoading: state is InquiryLoading,
                    onPressed: state is InquiryLoading ? null : _submit,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
