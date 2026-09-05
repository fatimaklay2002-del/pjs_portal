import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pjs_portal/features/settings/logic/settings_cubit.dart';
import 'core/Constants/app_constants.dart';
import 'core/di/injection.dart';
import 'core/init/app_bootstrap.dart';
import 'core/session/user_session.dart';
import 'core/theme/app_theme.dart';
import 'core/navigation/app_router.dart';
import 'features/admin/logic/admin_cubit.dart';
import 'features/admin/logic/admin_dashboard_cubit.dart';
import 'features/admin/logic/admin_membership_cubit.dart';
import 'features/auth/logic/auth_cubit.dart';
import 'features/members/logic/member_cubit.dart';
import 'features/membership/logic/membership_cubit.dart';
import 'features/news/logic/news_cubit.dart';
import 'features/notification/logic/notifications_cubit.dart';
import 'features/tickets/logic/members/member_tickets_cubit.dart';
import 'features/tickets/logic/admin/admin_tickets_cubit.dart';

void main() async {
  await AppBootstrap.init();
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sl<AuthCubit>()),
            BlocProvider(create: (context) => sl<MembershipCubit>()),
            BlocProvider(create: (context) => sl<AdminCubit>()),
            BlocProvider(create: (context) => sl<AdminDashboardCubit>()),
            BlocProvider(create: (context) => sl<AdminMembershipCubit>()),
            BlocProvider(create: (context) => sl<NewsCubit>()),
            BlocProvider(create: (context) => sl<TicketsCubit>()),
            BlocProvider(create: (context) => sl<AdminTicketsCubit>()),
            BlocProvider(create: (context) => sl<MemberCubit>()),
            BlocProvider(create: (context) => sl<SettingsCubit>()),
            BlocProvider(
              create: (context) {
                final cubit = sl<NotificationsCubit>();
                if (UserSession.instance.isLoaded) {
                  cubit.loadAndSubscribe();
                }
                return cubit;
              },
            ),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: AppConstants.appName,
            theme: AppTheme.lightTheme,
            routerConfig: AppRouter.router,

            // إعدادات اللغة العربية (RTL)
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ar', 'AE'),
            ],
            locale: const Locale('ar', 'AE'),

            builder: (context, child) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: child!,
              );
            },
          ),
        );
      },
    );
  }
}
