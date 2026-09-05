import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../members/data/model/member_model.dart';

class MemberBadge extends StatelessWidget {
  final MemberModel member;
  const MemberBadge({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    final isAdmin = member.role == 'admin';
    final isPermanent = member.membershipType == 'permanent';

    final label = isAdmin
        ? 'مسؤول'
        : isPermanent
        ? 'عضو دائم'
        : 'عضو مؤقت';

    final color = isAdmin
        ? AppColors.primaryNavy
        : isPermanent
        ? AppColors.accentBlue
        : AppColors.accentYellow;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(color: color),
      ),
    );
  }
}

class MemberAvatar extends StatelessWidget {
  final String name;
  const MemberAvatar({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0] : '?';
    return CircleAvatar(
      radius: 20.r,
      backgroundColor: AppColors.lightNavy.withValues(alpha: 0.2),
      child: Text(
        initial,
        style: AppTextStyles.titleSmall.copyWith(
          color: AppColors.primaryNavy,
        ),
      ),
    );
  }
}