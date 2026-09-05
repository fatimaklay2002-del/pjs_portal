import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pjs_portal/features/notification/ui/widgets/notification_card.dart';

import '../../../core/navigation/notification_navigation.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_formatter.dart';
import '../logic/notifications_cubit.dart';
import '../logic/notifications_state.dart';

class NotificationsScreen extends StatefulWidget {
  final bool isAdmin;
  const NotificationsScreen({super.key, this.isAdmin = false});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationsCubit>().loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('الإشعارات'),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                context.read<NotificationsCubit>().markAllAsRead(),
           icon: Icon(Icons.done_all_outlined,color: AppColors.primaryNavy,),
          ),
        ],
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is NotificationsError) {
            return Center(child: Text(state.message));
          }
          if (state is NotificationsLoaded) {
            if (state.notifications.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications_none_outlined,
                        size: 64.sp, color: AppColors.iconSecondary),
                    SizedBox(height: 12.h),
                    Text('لا توجد إشعارات',
                        style: AppTextStyles.bodyMedium),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () =>
                  context.read<NotificationsCubit>().loadNotifications(),
              child: ListView.separated(
                padding: EdgeInsets.all(16.w),
                itemCount: state.notifications.length,
                separatorBuilder: (_, _) => SizedBox(height: 10.h),
                itemBuilder: (context, i) {
                  final n = state.notifications[i];
                  return NotificationCard(
                    title: n.title,
                    body: n.body,
                    timeAgo: DateFormatter.toRelative(n.createdAt),
                    isRead: n.isRead,
                    onTap: () {
                      if (!n.isRead) {
                        context.read<NotificationsCubit>().markAsRead(n.id);
                      }
                      Navigator.pop(context);
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        NotificationNavigation.navigate(null, n);
                      });                   },
                  );
                },
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}