import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pjs_portal/features/admin/ui/members/widgets/role_chip.dart';

import '../../../../../core/Constants/app_strings.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../members/data/model/member_model.dart';
import '../../../logic/admin_cubit.dart';

class EditMemberSheet extends StatefulWidget {
  final MemberModel member;
  const EditMemberSheet({super.key, required this.member});

  @override
  State<EditMemberSheet> createState() => EditMemberSheetState();
}

class EditMemberSheetState extends State<EditMemberSheet> {
  late String _selectedRole;

  @override
  void initState() {
    super.initState();
    // تحديد الحالة الحالية للعضو
    if (widget.member.role == 'admin') {
      _selectedRole = 'admin';
    } else if (widget.member.membershipType == 'permanent') {
      _selectedRole = 'permanent';
    } else {
      _selectedRole = 'temporary';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.grey.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'تعديل العضوية',
              style: AppTextStyles.headlineSmall,
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                RoleChip(
                  label: 'عضو مؤقت',
                  icon: Icons.access_time,
                  value: 'temporary',
                  selected: _selectedRole == 'temporary',
                  onTap: () => setState(() => _selectedRole = 'temporary'),
                ),
                SizedBox(width: 10.w),
                RoleChip(
                  label: 'عضو دائم',
                  icon: Icons.verified_user_outlined,
                  value: 'permanent',
                  selected: _selectedRole == 'permanent',
                  onTap: () => setState(() => _selectedRole = 'permanent'),
                ),
                SizedBox(width: 10.w),
                RoleChip(
                  label: 'مسؤول',
                  icon: Icons.shield_outlined,
                  value: 'admin',
                  selected: _selectedRole == 'admin',
                  onTap: () => setState(() => _selectedRole = 'admin'),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryNavy,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  _applyChanges(context);
                },
                child: Text(AppStrings.save, style: AppTextStyles.button),
              ),
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  void _applyChanges(BuildContext context) {
    if (_selectedRole == 'admin') {
      context.read<AdminCubit>().changeMemberRole(
        memberId: widget.member.id,
        newRole: 'admin',
      );
    } else {
      // لو تغير من admin لعضو عادي
      if (widget.member.role == 'admin') {
        context.read<AdminCubit>().changeMemberRole(
          memberId: widget.member.id,
          newRole: 'journalist',
        );
      }
      context.read<AdminCubit>().changeMembershipType(
        memberId: widget.member.id,
        newType: _selectedRole,
      );
    }
  }
}
