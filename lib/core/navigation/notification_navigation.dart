import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pjs_portal/core/extensions/context_extensions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/admin/ui/admin_dashboard_screen.dart';

import '../../features/news/data/model/news_model.dart';

import '../../features/news/logic/news_cubit.dart';
import '../../features/news/ui/screens/news_detail_screen.dart';
import '../../features/notification/data/model/notification_model.dart';
import '../../features/tickets/ui/journalist/complaints/member_complaint_screen.dart';
import '../../features/tickets/ui/journalist/inquiries/member_inquiries_screen.dart';
import '../Constants/app_constants.dart';
import '../di/injection.dart';
import '../session/user_session.dart';
import 'app_navigator.dart';

class NotificationNavigation {
  static Map<String, int>? pendingAdminTab;
  static NewsModel? pendingNews;
  static void navigate(
    BuildContext? contextHint,
    NotificationModel notification,
  ) {
    final ctx = AppNavigator.context;
    if (ctx == null) return;

    final type = notification.type;
    final referenceId = notification.relatedId;

    switch (type) {
      // ── للأدمن ──
      case 'new_inquiry':
        _navigateAdmin(ctx, tabIndex: 3, subIndex: 0);
        break;

      case 'new_complaint':
        _navigateAdmin(ctx, tabIndex: 3, subIndex: 1);
        break;

      case 'new_request':
        _navigateAdmin(ctx, tabIndex: 1);
        break;

      // ── للمستخدم ──
      case 'inquiry_reply':
        AppNavigator.push(const InquiriesScreen());
        break;

      case 'complaint_reply':
        AppNavigator.push(const ComplaintScreen());
        break;

      //  إصلاح new_news — نجلب الخبر أولاً
      case 'new_news':
        if (referenceId != null) {
          _navigateToNews(ctx, referenceId);
        }
        break;
    }
  }

  // ── فتح الخبر بعد جلبه من Supabase ──
  static Future<void> _navigateToNews(
    BuildContext context,
    String newsId,
  ) async {
    try {
      final data = await Supabase.instance.client
          .from('news')
          .select()
          .eq('id', newsId)
          .single();

      final news = NewsModel.fromJson(data);
      final isAdmin = UserSession.instance.isAdmin;
      AppNavigator.push(
        BlocProvider.value(
          value: sl<NewsCubit>(),
          child: NewsDetailScreen(news: news, isAdmin: isAdmin),
        ),
      );
    } catch (e) {
      debugPrint('⚠️ Failed to load news for notification: $e');
      if (!context.mounted) return;
      context.showErrorSnackBar('عذراً، تعذر تحميل تفاصيل الخبر');
    }
  }

  // ── للأدمن — الانتقال للتاب الصح ──
  static void _navigateAdmin(
    BuildContext context, {
    required int tabIndex,
    int subIndex = 0,
  }) {
    final dashboardState = AdminDashboardScreenState.current;
    if (dashboardState != null && dashboardState.mounted) {
      dashboardState.jumpToTab(tabIndex, subIndex: subIndex);
    } else {
      pendingAdminTab = {'tab': tabIndex, 'sub': subIndex};
      // خارج الـ Dashboard
      AppNavigator.navigatorKey.currentContext?.go(
        AppConstants.routeAdminDashboard,
      );
    }
  }
}
