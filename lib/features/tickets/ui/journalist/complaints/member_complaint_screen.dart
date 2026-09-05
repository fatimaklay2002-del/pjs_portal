import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pjs_portal/core/extensions/context_extensions.dart';
import 'package:pjs_portal/core/widgets/primary_button.dart';

import '../../../../../../core/theme/app_color.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/Constants/app_strings.dart';
import '../../../logic/members/member_tickets_cubit.dart';
import '../../../logic/members/member_tickets_state.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_descriptionController.text.trim().isEmpty) {
      context.showErrorSnackBar(AppStrings.fillComplaintDetails);
      return;
    }
    context.read<TicketsCubit>().sendComplaint(
      description: _descriptionController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(AppStrings.complaintTitle, style: AppTextStyles.headlineMedium),
      ),
      body: BlocListener<TicketsCubit, TicketsState>(
        listener: (context, state) {
          if (state is TicketsActionSuccess && state.type == TicketType.complaint) {
            context.showSuccessSnackBar(state.message);
            _descriptionController.clear();
          }
          if (state is TicketsError) {
            context.showErrorSnackBar(state.message);
          }
        },
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon
                  Container(
                    width: 56.w,
                    height: 56.w,
                    decoration: BoxDecoration(
                      color: AppColors.lightNavy.withValues(alpha: .15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      Icons.shield_outlined,
                      color: AppColors.primaryNavy,
                      size: 28.w,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Title
                  Text(
                    AppStrings.complaintTitle,
                    style: AppTextStyles.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 6.h),

                  // Subtitle
                  Text(
                    AppStrings.complaintSubTitle,
                    style: AppTextStyles.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.h),

                  // Description
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _descriptionController,
                      maxLines: 6,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: AppTextStyles.bodyMedium,
                      decoration: InputDecoration(
                        hintText: AppStrings.complaintHint,
                        hintStyle: AppTextStyles.hint,
                        hintTextDirection: TextDirection.rtl,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16.w),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Submit Button
                  BlocBuilder<TicketsCubit, TicketsState>(
                    builder: (context, state) {
                      return PrimaryButton(
                        text: AppStrings.sendComplaint,
                        isLoading: state is InquiryLoading,
                        onPressed: state is InquiryLoading ? null : _submit,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
