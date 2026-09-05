import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pjs_portal/core/extensions/navigation_extensions.dart';
import 'package:pjs_portal/features/admin/ui/widgets/admin_nav_bar.dart';
import '../../../core/navigation/notification_navigation.dart';
import '../../../core/service/notification_service.dart';
import '../../../core/theme/app_color.dart';
import '../../news/logic/news_cubit.dart';
import '../../news/ui/screens/add_update_news.dart';
import '../../settings/logic/settings_cubit.dart';
import '../../settings/settings_screen.dart';
import '../../tickets/logic/admin/admin_tickets_cubit.dart';
import '../../tickets/ui/admin/admin_inbox_screen.dart';
import '../logic/admin_dashboard_cubit.dart';
import '../logic/admin_membership_cubit.dart';
import 'membership_requests_list_screen.dart';
import 'admin_home_tab.dart';


class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  static AdminDashboardScreenState? of(BuildContext context) =>
      context.findAncestorStateOfType<AdminDashboardScreenState>();

  @override
  State<AdminDashboardScreen> createState() => AdminDashboardScreenState();
}

class AdminDashboardScreenState extends State<AdminDashboardScreen> {
  static AdminDashboardScreenState? current;
  int _selectedIndex = 0;
  late final List<Widget> _screens;

  // الـ Controller المسؤول عن توجيه التبويب الداخلي لصندوق الوارد
  final _inboxTabController = _InboxTabController();

  @override
  void initState() {
    super.initState();
    current = this;

    _screens = [
      const AdminHomeTab(),
      const MembershipRequestsListScreen(),
      const SizedBox.shrink(),
      _InboxScreenWrapper(controller: _inboxTabController),
      const SettingsScreen(),
    ];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (NotificationNavigation.pendingAdminTab != null) {
        final data = NotificationNavigation.pendingAdminTab!;
        jumpToTab(data['tab']!, subIndex: data['sub']!);
        NotificationNavigation.pendingAdminTab = null;
      } else {
        _loadTab(0);
      }
      NotificationService.handlePendingNavigation(context);
    });
  }

  @override
  void dispose() {
    if (current == this) current = null;
    _inboxTabController.dispose(); // حماية من تسريب الذاكرة
    super.dispose();
  }

  void jumpToTab(int index, {int subIndex = 0}) {
    if (index == 3) {
      _inboxTabController.setTab(subIndex);
    }
    setState(() => _selectedIndex = index);
    _loadTab(index);
  }

  void _loadTab(int index) {
    switch (index) {
      case 0:
        context.read<AdminDashboardCubit>().loadDashboardStats();
        context.read<NewsCubit>().loadNews();
        break;
      case 1:
        context.read<AdminMembershipCubit>().loadPendingRequests();
        break;
      case 3:
        context.read<AdminTicketsCubit>().loadAll();
        break;
      case 4:
        context.read<SettingsCubit>().loadInitialSettings();
        break;
    }
  }

  void _onTabTapped(int index) {
    if (index == 2) return;
    if (index == _selectedIndex) {
      _loadTab(index);
      return;
    }
    setState(() => _selectedIndex = index);
    _loadTab(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      floatingActionButton: AdminAddNewsButton(
        onPressed: () {
          context.pushWithCubit(context.read<NewsCubit>(), const NewsAddEditScreen());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AdminNavBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

class _InboxTabController extends ChangeNotifier {
  int currentTab = 0;

  void setTab(int tab) {
    // عدم إطلاق إشعار إذا ضغط على نفس التبويب لتوفير موارد المعالجة
    if (currentTab == tab) return;
    currentTab = tab;
    notifyListeners();
  }
}

class _InboxScreenWrapper extends StatefulWidget {
  final _InboxTabController controller;
  const _InboxScreenWrapper({required this.controller});

  @override
  State<_InboxScreenWrapper> createState() => _InboxScreenWrapperState();
}

class _InboxScreenWrapperState extends State<_InboxScreenWrapper> {

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTabChanged);
  }

  @override
  void didUpdateWidget(covariant _InboxScreenWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    // حماية التغيير: إذا تم استبدال الـ Controller بروتوكولياً من الأعلى
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onTabChanged);
      widget.controller.addListener(_onTabChanged);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTabChanged);
    super.dispose();
  }

  void _onTabChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final tabIndex = widget.controller.currentTab;

    return AdminInboxScreen(
      key: ValueKey('admin_inbox_tab_$tabIndex'),
      initialTabIndex: tabIndex,
    );
  }
}