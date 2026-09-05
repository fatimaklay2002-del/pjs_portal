import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/Constants/app_strings.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../members/data/model/member_model.dart';
import '../../../logic/admin_cubit.dart';
import 'action_icon.dart';
import 'edit_member_sheet.dart';
import 'member_badge.dart';

class MemberCard extends StatelessWidget {
  final MemberModel member;

  const MemberCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          MemberAvatar(name: member.fullNameAr),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.fullNameAr,
                  style: AppTextStyles.titleMedium,
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: 2.h),
                Text(
                  member.email,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // ── أيقونات الإجراءات ──
          Row(
            children: [
              ActionIcon(
                icon: Icons.delete_outline,
                color: AppColors.accentRed,
                onTap: () => _showDeleteDialog(context),
              ),
              SizedBox(width: 8.w),
              ActionIcon(
                icon: Icons.edit_outlined,
                color: AppColors.accentBlue,
                onTap: () => _showEditMenu(context),
              ),
            ],
          ),
          SizedBox(width: 8.w),

          // ── Badge نوع العضوية ──
          MemberBadge(member: member),




        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'حذف العضو',
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
        ),
        content: Text(
          'هل أنت متأكد من حذف ${member.fullNameAr}؟',
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppStrings.cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentRed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              context.read<AdminCubit>().deleteMember(member.id,member.id);
            },
            child: Text(
              AppStrings.delete,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<AdminCubit>(),
        child: EditMemberSheet(member: member),
      ),
    );
  }
}
