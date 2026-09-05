import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminBuildIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;
  const AdminBuildIconButton({super.key, required this.icon, required this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.h,
      width: 24.w,
      decoration: BoxDecoration(
        color: color.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        icon: Icon(icon, color: color, size: 14.sp),
        onPressed: onPressed,
      ),
    );
  }
}
