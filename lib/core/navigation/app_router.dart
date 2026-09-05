import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/admin/ui/admin_dashboard_screen.dart';
import '../../features/auth/logic/auth_cubit.dart';
import '../../features/auth/logic/auth_state.dart';
import '../../features/auth/ui/screens/login_screen.dart';
import '../../features/auth/ui/screens/welcome_screen.dart';
import '../../features/members/ui/screens/member_dashboard_screen.dart';
import '../../features/membership/ui/screens/membership_request_screen.dart';
import '../../features/news/data/model/news_model.dart';
import '../../features/news/ui/screens/news_detail_screen.dart';
import '../../features/settings/settings_sub_screens/about_app_screen.dart';
import '../../features/settings/settings_sub_screens/about_developers_screen.dart';
import '../../features/settings/settings_sub_screens/privacy_policy_screen.dart';
import '../../features/settings/settings_sub_screens/terms_screen.dart';
import '../Constants/app_constants.dart';
import '../di/injection.dart';
import '../session/user_session.dart';
import 'app_navigator.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: AppNavigator.navigatorKey,
    initialLocation:AppConstants.routeWelcome,
    redirect: (context, state) {
      final authState = sl<AuthCubit>().state;
      if (authState is AuthInitial || authState is AuthLoading) return null;
      final isLoggedIn = authState is AuthAuthenticated;
      final isAuthRoute = [
        AppConstants.routeWelcome,
        AppConstants.routeAdminLogin,
        AppConstants.routeEmployeeLogin,
        AppConstants.routeMembershipRequest,
      ].contains(state.matchedLocation);

      if (!isLoggedIn && !isAuthRoute) return AppConstants.routeWelcome;
      if (isLoggedIn && isAuthRoute) {
        return UserSession.instance.isAdmin
            ? AppConstants.routeAdminDashboard
            : AppConstants.routeUserHome;
      }

      return null;
    },
    refreshListenable: GoRouterRefreshStream(sl<AuthCubit>().stream),
    routes: [
      // Welcome Screen*
      GoRoute(
        path: AppConstants.routeWelcome,
        name: 'welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),

      // Admin Login
      GoRoute(
        path: AppConstants.routeAdminLogin,
        name: 'admin-login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppConstants.routeEmployeeLogin,
        name: 'user-login',
        builder: (context, state) => const LoginScreen(),
      ),

      // Admin Dashboard
      GoRoute(
        path: AppConstants.routeAdminDashboard,
        name: 'admin-dashboard',
        builder: (context, state) => const AdminDashboardScreen(), // AdminDashboardScreen(),
      ),

      // Membership Request
      GoRoute(
        path: AppConstants.routeMembershipRequest,
        name: 'membership-request',
        builder: (context, state) => const MembershipRequestScreen(),
      ),

      // User Home
      GoRoute(
        path: AppConstants.routeUserHome,
        name: 'user-home',
        builder: (context, state) => const EmployeeDashboardScreen(), // UserHomeScreen(),
      ),
      GoRoute(
        path: AppConstants.routeNewsDetails, // أو أي مسار تفضلينه
        name: 'news-details',
        builder: (context, state){
          final news = state.extra as NewsModel;
          final isAdmin = UserSession.instance.isAdmin;
          return NewsDetailScreen(
            news: news,
            isAdmin: isAdmin,
          );
        },
      ),

      GoRoute(
        path: AppConstants.routeTerm, // أو أي مسار تفضلينه
        name: 'terms',
        builder: (context, state) => const TermsScreen(),
      ),
      GoRoute(
        path: AppConstants.routePrivacy,
        name: 'privacy',
        builder: (context, state) => const PrivacyPolicyScreen(),
      ),
      GoRoute(
        path: AppConstants.routeAboutApp,
        name: 'about-app',
        builder: (context, state) => const AboutAppScreen(),
      ),
      GoRoute(
        path: AppConstants.routeAboutDeveloper,
        name: 'about-developer',
        builder: (context, state) => const AboutDevelopersScreen(),
      ),
    ],

    // Error handling
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('خطأ: ${state.error}'),
      ),
    ),
  );
}
class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription _subscription;

  GoRouterRefreshStream(Stream stream) {
    notifyListeners();
    _subscription = stream.listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}