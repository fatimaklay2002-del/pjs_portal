import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pjs_portal/features/admin/ui/members/widgets/export_button.dart';
import 'package:pjs_portal/features/admin/ui/members/widgets/member_card.dart';

import '../../../../core/Constants/app_strings.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/filter_row.dart';
import '../../logic/admin_cubit.dart';
import '../../logic/admin_members_state.dart';
class AllMembersScreen extends StatefulWidget {
  const AllMembersScreen({super.key});

  @override
  State<AllMembersScreen> createState() => _AllMembersScreenState();
}

class _AllMembersScreenState extends State<AllMembersScreen> {
  final _filters = [
    ('temporary', 'عضو مؤقت'),
    ('permanent', 'عضو دائم'),
    ('admin', 'مسؤول'),
    ('all', 'الكل'),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminCubit>().loadMembers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(AppStrings.totalMembers),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocConsumer<AdminCubit, AdminMembersState>(
        listener: (context, state) {
          if (state is AdminMembersError) {
            context.showErrorSnackBar(state.message);
          }
          if (state is AdminMembersActionSuccess) {
            context.showSuccessSnackBar(state.message);
          }
        },
        buildWhen: (previous, current) {
          // نمنع إعادة بناء الشاشة بالكامل إذا كانت الحالة مجرد تحميل إجراء (حذف أو تعديل)
          // لأن الـ Cubit سيعيد إطلاق حالة AdminMembersLoaded المحدثة فوراً بعدها
          return current is AdminMembersLoading ||
              current is AdminMembersLoaded ||
              current is AdminMembersInitial;
        },
        builder: (context, state) {
          if (state is AdminMembersLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AdminMembersLoaded) {
            final currentFilter = state.currentFilter;
            final filtered = state.filteredMembers;
            final counts = context.read<AdminCubit>().buildCounts();

            return Stack(
              children: [
                Column(
                  children: [
                    // ── Filter Chips ──
                    FilterRow(
                      filters: _filters,
                      selected: currentFilter,
                      counts: counts,
                      onSelected: (val) =>
                          context.read<AdminCubit>().updateFilter(val),
                    ),

                    // ── Members List ──
                    Expanded(
                      child: filtered.isEmpty
                          ? Center(
                        child: Text(
                          AppStrings.noData,
                          style: AppTextStyles.bodyMedium,
                        ),
                      )
                          : RefreshIndicator(
                        onRefresh: () =>
                            context.read<AdminCubit>().loadMembers(),
                        child: ListView.separated(
                          padding: EdgeInsets.all(16.w),
                          itemCount: filtered.length,
                          separatorBuilder: (_, _) => SizedBox(height: 10.h),
                          itemBuilder: (_, i) =>
                              MemberCard(member: filtered[i]),
                        ),
                      ),
                    ),

                    // ── Export Button ──
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: ExportButton(members: filtered),
                      ),
                    ),
                  ],
                ),

                // طبقة حماية شفافة تمنع نقرات الآدمن العشوائية أثناء تفعيل الحذف في السيرفر
                if (context.watch<AdminCubit>().state is AdminMembersActionLoading)
                  Container(
                    color: Colors.black.withValues(alpha: 0.1),
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryNavy),
                      ),
                    ),
                  ),
              ],
            );
          }

          // شاشة الخطأ أو إعادة المحاولة الافتراضية
          return Center(
            child: ElevatedButton(
              onPressed: () => context.read<AdminCubit>().loadMembers(),
              child: Text(AppStrings.retry),
            ),
          );
        },
      ),
    );
  }
}