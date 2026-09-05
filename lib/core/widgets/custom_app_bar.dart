import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/notification/logic/notifications_cubit.dart';
import '../../features/notification/logic/notifications_state.dart';
import '../../features/notification/ui/notifications_screen.dart';
import '../Constants/app_strings.dart';
import '../theme/app_color.dart';
import '../theme/app_text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isAdmin;
  const CustomAppBar({
    super.key,
    this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 60.h,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/logo.jpeg',
                width: 32.w,
                height: 32.h,
                errorBuilder: (_, _, _) => Icon(
                  Icons.verified,
                  color: AppColors.primaryNavy,
                  size: 28.w,
                ),
              ),
              SizedBox(width: 8.w),
              Text(AppStrings.appName, style: AppTextStyles.headlineSmall),
            ],
          ),
          BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, state) {
              final unread = state is NotificationsLoaded ? state.unreadCount : 0;
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<NotificationsCubit>(),
                            child: const NotificationsScreen(),
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.notifications_active_outlined,
                      size: 24.sp,
                      color: AppColors.iconSecondary,
                    ),
                  ),
                  if (unread > 0)
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: _buildNotificationBadge(unread),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationBadge(int count) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppColors.accentRed,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      constraints: BoxConstraints(minWidth: 16.w, minHeight: 16.h),
      child: Center(
        child: Text(
          count > 9 ? '9+' : '$count',
          style: TextStyle(color: Colors.white, fontSize: 8.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}