import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pjs_portal/core/extensions/context_extensions.dart';
import 'package:pjs_portal/core/extensions/navigation_extensions.dart';
import 'package:pjs_portal/core/theme/app_color.dart';

import '../../../core/Constants/app_strings.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../membership/data/model/membership_request_model.dart';
import '../logic/admin_membership_cubit.dart';
import '../logic/admin_membership_state.dart';
import 'membership_request_review_screen.dart';

class MembershipRequestsListScreen extends StatefulWidget {
  const MembershipRequestsListScreen({super.key});

  @override
  State<MembershipRequestsListScreen> createState() =>
      _MembershipRequestsListScreenState();
}

class _MembershipRequestsListScreenState
    extends State<MembershipRequestsListScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("طلبات العضوية"),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<AdminMembershipCubit, AdminMembershipState>(
        listener: (context, state) {
          if (state is AdminMembershipError) {
            context.showErrorSnackBar(state.message);
          }
        },
        builder: (context, state) {
          debugPrint('🔴 AdminState: ${state.runtimeType}');
          if (state is AdminMembershipError) {
            debugPrint('🔴 Error: ${state.message}');
          }
            if (state is AdminMembershipLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AdminMembershipRequestsLoaded) {
            if (state.requests.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inbox_outlined,
                      size: 64.sp,
                      color: AppColors.iconSecondary,
                    ),
                    SizedBox(height: 16.h),
                    Text('لا توجد طلبات معلقة', style: AppTextStyles.bodyLarge),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                await context.read<AdminMembershipCubit>().loadPendingRequests();
              },
              child: ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: state.requests.length,
                itemBuilder: (context, index) {
                  final request = state.requests[index];
                  return _buildRequestCard(request, context);
                },
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildRequestCard(MembershipRequestModel  request, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Color(0xFFE2E8F0), width: 0.8),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                request.fullNameAr,
                style: AppTextStyles.titleMedium,
                textAlign: TextAlign.right,
              ),
              SizedBox(height: 8.h),
              Text(
                request.email,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              context.pushWithCubit(context.read<AdminMembershipCubit>(),MembershipRequestReviewScreen(requestId: request.id!));
            },
            child: Text(
              AppStrings.review,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.primaryNavy,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
