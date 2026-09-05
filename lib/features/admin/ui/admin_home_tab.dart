import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pjs_portal/core/extensions/navigation_extensions.dart';
import 'package:pjs_portal/core/widgets/custom_app_bar.dart';
import 'package:pjs_portal/features/admin/logic/admin_dashboard_state.dart';
import 'package:pjs_portal/features/news/ui/widgets/news_card.dart';
import 'package:pjs_portal/features/admin/ui/widgets/stat_card.dart';

import '../../../core/Constants/app_strings.dart';
import '../../../core/dialogs/delete_news_dialog.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../news/logic/news_cubit.dart';
import '../../news/logic/news_state.dart';
import '../../news/ui/screens/add_update_news.dart';
import '../../news/ui/screens/news_screen.dart';
import '../logic/admin_cubit.dart';
import '../logic/admin_dashboard_cubit.dart';
import 'admin_dashboard_screen.dart';
import 'members/all_members_screen.dart';

class AdminHomeTab extends StatefulWidget {
  const AdminHomeTab({super.key});

  @override
  State<AdminHomeTab> createState() => _AdminHomeTabState();
}

class _AdminHomeTabState extends State<AdminHomeTab>  with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<AdminDashboardCubit>().loadDashboardStats();
      context.read<NewsCubit>().loadNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        isAdmin: true,
      ),
      body: BlocBuilder<AdminDashboardCubit, AdminDashboardState>(
        builder: (context, state) {
          if (state is AdminDashboardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AdminDashboardLoaded) {
            return _buildBody(state);
          } else if (state is AdminDashboardError) {
            return _buildErrorState(state);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildBody(AdminDashboardLoaded state) {
    final stats = state.stats;

    return RefreshIndicator(
      onRefresh: () async {
        final cubit = context.read<AdminDashboardCubit>();
        final newsCubit = context.read<NewsCubit>();
        await cubit.loadDashboardStats();
        await newsCubit.loadNews();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Stats Grid ──
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Wrap(
                spacing: 16.w,
                runSpacing: 16.h,
                children: [
                  StatCard(
                    title: AppStrings.totalMembers,
                    value: '${stats.totalMembers}',
                    icon: SvgPicture.asset(
                      'assets/icons/admin_total_members_icon.svg',
                    ),
                    backgroundColor: AppColors.primaryNavy,
                    valueColor: AppColors.white,
                    onTap: () {
                      context.pushWithCubit(context.read<AdminCubit>(),AllMembersScreen());
                    },
                  ),
                  StatCard(
                    title: AppStrings.membershipRequests,
                    value: '${stats.pendingRequests}',
                    icon: SvgPicture.asset(
                      'assets/icons/admin_request_members_icon.svg',
                    ),
                    backgroundColor: AppColors.white,
                    textColor: AppColors.textPrimary,
                    valueColor: AppColors.accentYellow,
                    onTap: () {
                      AdminDashboardScreen.of(context)?.jumpToTab(1);
                    },
                  ),
                  StatCard(
                    title: AppStrings.complaints,
                    value: '${stats.pendingComplaints}',
                    icon: SvgPicture.asset('assets/icons/admin_complaint.svg'),
                    backgroundColor: AppColors.white,
                    textColor: AppColors.textPrimary,
                    valueColor: AppColors.accentRed,
                    onTap: () {
                      AdminDashboardScreen.of(context)?.jumpToTab(3, subIndex: 1);
                    },
                  ),
                  StatCard(
                    title: AppStrings.inquiries,
                    value: '${stats.pendingInquiries}',
                    icon: SvgPicture.asset(
                      'assets/icons/admin_inquiries_home_icon.svg',
                    ),
                    backgroundColor: AppColors.white,
                    textColor: AppColors.textPrimary,
                    valueColor: AppColors.iconSecondary,
                    onTap: () {
                      AdminDashboardScreen.of(context)?.jumpToTab(3, subIndex: 0);
                    },
                  ),
                ],
              ),
            ),

            // ── News Section Header ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.latestNews,
                    style: AppTextStyles.headlineSmall,
                  ),
                  GestureDetector(
                    onTap: () => context.pushWithCubit(context.read<NewsCubit>(), NewsScreen(isAdmin: true,)),
                    child: Row(
                      children: [
                        Text(
                          AppStrings.viewAll,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.primaryNavy,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14.sp,
                          color: AppColors.primaryNavy,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),

            // ── News List from NewsCubit ──
            BlocBuilder<NewsCubit, NewsState>(
              builder: (context, newsState) {
                if (newsState is NewsLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (newsState is NewsLoaded && newsState.news.isNotEmpty) {
                  // Show only latest 5
                  final latest = newsState.news.take(5).toList();
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: latest.length,
                    separatorBuilder: (_, _) => SizedBox(height: 12.h),
                    itemBuilder: (context, i) => NewsCard(
                      isAdmin: true,
                      news: latest[i],
                      onEdit: () =>context.pushWithCubit(context.read<NewsCubit>(), NewsAddEditScreen(news: latest[i])),
                     onDelete: () async {
                        final cubit = context.read<NewsCubit>();
                        final confirmed = await showDeleteNewsDialog(context);
                        if (confirmed == true) {
                          cubit.deleteNews(latest[i].id);
                        }
                      },

                    ),
                  );
                }
                return Padding(
                  padding: EdgeInsets.all(32.w),
                  child: Center(
                    child: Text(
                      AppStrings.emptyNews,
                      style: AppTextStyles.bodyMedium,
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 80.h),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(AdminDashboardError state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64.sp, color: AppColors.accentRed),
          SizedBox(height: 16.h),
          Text(state.message, style: AppTextStyles.bodyLarge),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () => context.read<AdminDashboardCubit>().loadDashboardStats(),
            child: Text(AppStrings.retry),
          ),
        ],
      ),
    );
  }
}
