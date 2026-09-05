import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pjs_portal/features/tickets/ui/admin/inquiries/widgets/admin_inquiry_card.dart';

import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/date_formatter.dart';
import '../../../data/model/ticket_model.dart';
import '../../../logic/admin/admin_tickets_cubit.dart';

class InquiriesTab extends StatelessWidget {
  final List<TicketModel> inquiries;
  const InquiriesTab({super.key, required this.inquiries});



  @override
  Widget build(BuildContext context) {
    if (inquiries.isEmpty) {
      return Center(
        child: Text('لا توجد استفسارات', style: AppTextStyles.bodyMedium),
      );
    }
    return RefreshIndicator(
      onRefresh: () => context.read<AdminTicketsCubit>().loadAll(),
      child: ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemCount: inquiries.length,
        separatorBuilder: (_, _) => SizedBox(height: 10.h),
        itemBuilder: (_, i) => AdminInquiryCard(
          inquiry: inquiries[i],
          date: DateFormatter.toArabic(inquiries[i].createdAt),
        ),
      ),
    );
  }
}