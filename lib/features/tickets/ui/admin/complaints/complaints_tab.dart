import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:pjs_portal/features/tickets/ui/admin/complaints/widgets/complaint_card.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../data/model/ticket_model.dart';
import '../../../logic/admin/admin_tickets_cubit.dart';

class ComplaintsTab extends StatelessWidget {
  final List<TicketModel> complaints;
  const ComplaintsTab({super.key, required this.complaints});

  @override
  Widget build(BuildContext context) {
    if (complaints.isEmpty) {
      return Center(child: Text('لا توجد شكاوى', style: AppTextStyles.bodyMedium));
    }
    return RefreshIndicator(
      onRefresh: () => context.read<AdminTicketsCubit>().loadAll(),
      child: ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemCount: complaints.length,
        separatorBuilder: (_, _) => SizedBox(height: 10.h),
        itemBuilder: (_, i) {
          final complaint = complaints[i];
          return FocusedMenuHolder(
            openWithTap: true,
            onPressed: () {},
            menuWidth: 150.w,
            blurSize: 4.0,
            duration: const Duration(milliseconds: 200),
            animateMenuItems: true,
            bottomOffsetHeight: 20.h,
            menuOffset: 4.h,
            menuBoxDecoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 4))],
            ),
            menuItems: [
              _menuItem('قيد المعالجة', () => _updateStatus(context, complaint.id, 'under_processing')),
              _menuItem('تم الحل', () => _updateStatus(context, complaint.id, 'resolved')),
              _menuItem('معلق', () => _updateStatus(context, complaint.id, 'pending')),
            ],
            child: ComplaintCard(complaint: complaint),
          );
        },
      ),
    );
  }

  FocusedMenuItem _menuItem(String label, VoidCallback onPressed) {
    return FocusedMenuItem(
      backgroundColor: Colors.white,
      title: Column(
        children: [
          Text(label, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary)),
          SizedBox(height: 2.h),
          Divider(height: 1, thickness: 0.5, color: AppColors.lightGrey),
        ],
      ),
      onPressed: onPressed,
    );
  }

  void _updateStatus(BuildContext context, String id, String status) {
    context.read<AdminTicketsCubit>().updateComplaintStatus(complaintId: id, status: status);
  }
}
