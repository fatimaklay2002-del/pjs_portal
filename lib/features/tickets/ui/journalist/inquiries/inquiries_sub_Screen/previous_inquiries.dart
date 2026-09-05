import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/Constants/app_strings.dart';
import '../../../../../../core/theme/app_color.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/utils/date_formatter.dart';
import '../../../../logic/members/member_tickets_cubit.dart';
import '../../../../logic/members/member_tickets_state.dart';
import '../widgets/inquiry_card.dart';


class PreviousInquiriesTab extends StatelessWidget {
  const PreviousInquiriesTab({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketsCubit, TicketsState>(
      builder: (context, state) {
        if (state is TicketsInitial) {
          context.read<TicketsCubit>().loadMyInquiries();
          return const Center(child: CircularProgressIndicator());
        }
        if (state is InquiryLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is InquiriesLoaded) {
          if (state.inquiries.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.question_answer_outlined,
                      size: 56.w, color: AppColors.iconSecondary),
                  SizedBox(height: 12.h),
                  Text(AppStrings.emptyInquiries,
                      style: AppTextStyles.bodyMedium),
                ],

              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () =>
                context.read<TicketsCubit>().loadMyInquiries(),
            child: ListView.separated(
              padding: EdgeInsets.all(16.w),
              itemCount: state.inquiries.length,
              separatorBuilder: (_, _) => SizedBox(height: 12.h),
              itemBuilder: (context, i) {
                final inq = state.inquiries[i];
                return InquiryCard(
                  inquiry: inq,
                  date: DateFormatter.toArabic(inq.createdAt),
                );
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
