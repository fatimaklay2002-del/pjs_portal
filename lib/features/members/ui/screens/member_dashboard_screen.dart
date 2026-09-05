import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pjs_portal/features/settings/settings_screen.dart';
import 'package:pjs_portal/features/members/ui/widgets/member_nav_bar.dart';

import '../../../../core/service/notification_service.dart';

import '../../../news/logic/news_cubit.dart';
import '../../../settings/logic/settings_cubit.dart';
import '../../../tickets/ui/journalist/complaints/member_complaint_screen.dart';
import '../../../tickets/ui/journalist/inquiries/member_inquiries_screen.dart';
import 'member_home_tab.dart';

class EmployeeDashboardScreen extends StatefulWidget {
  const EmployeeDashboardScreen({super.key});

  @override
  State<EmployeeDashboardScreen> createState() =>
      _EmployeeDashboardScreenState();
}

class _EmployeeDashboardScreenState extends State<EmployeeDashboardScreen> {
  int _currentIndex = 0;

  // 0=Home, 1=Complaint, 2=Inquiry, 3=Settings
  final List<Widget> _screens = [
    const MemberHomeTab(),
    const ComplaintScreen(),
    const InquiriesScreen(),
    const SettingsScreen(),
  ];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NotificationService.handlePendingNavigation(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: MemberNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _loadDataForTab(index);
        },
      ),
    );
  }
  void _loadDataForTab(int index) {
    switch (index) {
      case 0:
        context.read<NewsCubit>().loadNews();
        break;
      case 3:
        context.read<SettingsCubit>().loadInitialSettings();
        break;
    }
  }
}

