import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pjs_portal/core/Constants/app_strings.dart';
import 'package:pjs_portal/core/extensions/context_extensions.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../logic/admin/admin_tickets_cubit.dart';
import '../../logic/admin/admin_tickets_state.dart';
import 'complaints/complaints_tab.dart';
import 'inquiries/inquiries_tab.dart';

class AdminInboxScreen extends StatefulWidget {
  final int initialTabIndex;
  const AdminInboxScreen({super.key, this.initialTabIndex = 0});

  @override
  State<AdminInboxScreen> createState() => _AdminInboxScreenState();
}

class _AdminInboxScreenState extends State<AdminInboxScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<AdminTicketsCubit>().state;
      if (state is AdminInquiryInitial) {
        context.read<AdminTicketsCubit>().loadAll();
      }});
  }
  @override
  void didUpdateWidget(AdminInboxScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialTabIndex != widget.initialTabIndex) {
      _tabController.animateTo(widget.initialTabIndex);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(AppStrings.inbox, style: AppTextStyles.headlineMedium),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.h),
          child: Container(
            color: AppColors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.primaryNavy,
              unselectedLabelColor: AppColors.grey,
              indicatorColor: AppColors.primaryNavy,
              indicatorWeight: 2,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: AppColors.grey,
              tabs: const [
                Tab(text: AppStrings.inquiries),
                Tab(text: AppStrings.complaints),
              ],
            ),
          ),
        ),
      ),
      body: BlocConsumer<AdminTicketsCubit, AdminInquiryState>(
        listener: (context, state) {
          if (state is AdminInquiryActionSuccess) {
            context.showSuccessSnackBar(state.message);
          }
        },

        builder: (context, state) {
          debugPrint('🔴 InquiryState: ${state.runtimeType}');
          if (state is AdminInquiryError) {
            debugPrint('🔴 Error message: ${state.message}');
            return Center(child: Text(state.message));
          }
          if (state is AdminInquiryLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AdminInquiryLoaded){
            return TabBarView(
              controller: _tabController,
              children: [
                InquiriesTab(inquiries: state.inquiries),
                ComplaintsTab(complaints: state.complaints),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
