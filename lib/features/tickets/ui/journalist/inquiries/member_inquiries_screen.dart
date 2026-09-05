import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/Constants/app_strings.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../logic/members/member_tickets_cubit.dart';
import 'inquiries_sub_Screen/new_inquiry.dart';
import 'inquiries_sub_Screen/previous_inquiries.dart';

class InquiriesScreen extends StatefulWidget {
  const InquiriesScreen({super.key});

  @override
  State<InquiriesScreen> createState() => _InquiriesScreenState();
}

class _InquiriesScreenState extends State<InquiriesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    context.read<TicketsCubit>().loadMyInquiries();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(AppStrings.inquiries, style: AppTextStyles.headlineMedium),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.h),
          child: Container(
            color: AppColors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.primaryNavy,
              unselectedLabelColor: AppColors.lightGrey,
              labelStyle: AppTextStyles.labelMedium
                  .copyWith(fontWeight: FontWeight.w600),
              indicatorColor: AppColors.primaryNavy,
              indicatorWeight: 2,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: AppColors.grey,
              tabs: const [
                Tab(text: AppStrings.newInquiry),
                Tab(text: AppStrings.previousInquiries),

              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          NewInquiryTab(),
          PreviousInquiriesTab(),

        ],
      ),
    );
  }
}


