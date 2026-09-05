import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

class UserInfoCard extends StatelessWidget {
  final String name;
  final String email;
  final String ? membershipType;
  const UserInfoCard({super.key, required this.name, required this.email, required this.membershipType});

  String get _label => membershipType == 'permanent' ? 'عضو دائم' : 'عضو مؤقت';
  Color get _color => membershipType == 'permanent' ? AppColors.success : AppColors.accentYellow;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: AppColors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(color: AppColors.lightNavy.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(Icons.person, color: AppColors.primaryNavy, size: 22.w),
          ),
          SizedBox(width: 12.w),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name, style: AppTextStyles.titleSmall),
            SizedBox(height: 2.h),
            Text(email, style: AppTextStyles.bodySmall),
          ]),


          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: _color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _color.withValues(alpha: 0.3)),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Container(width: 6.w, height: 6.w, decoration: BoxDecoration(color: _color, shape: BoxShape.circle)),
              SizedBox(width: 4.w),
              Text(_label, style: AppTextStyles.labelSmall.copyWith(color: _color)),
            ]),
          ),


        ],
      ),
    );
  }
}
