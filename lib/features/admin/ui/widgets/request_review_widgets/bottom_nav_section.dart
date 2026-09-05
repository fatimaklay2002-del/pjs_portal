import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pjs_portal/features/admin/logic/admin_membership_cubit.dart';
import 'package:pjs_portal/features/admin/logic/admin_membership_state.dart';

import '../../../../../core/theme/app_color.dart';
import '../../../../../core/widgets/custom_outlined_button.dart';
import '../../../../../core/widgets/primary_button.dart';


class BottomNavSection extends StatelessWidget {
  final int currentPage;
  final PageController pageController;
  final VoidCallback onApprove;
  final VoidCallback onReject;
  final bool isLoading;

  const BottomNavSection({
    super.key,
    required this.currentPage,
    required this.pageController,
    required this.onApprove,
    required this.onReject,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BlocBuilder<AdminMembershipCubit, AdminMembershipState>(
        builder: (context, state) {
          final isLoading = state is AdminMembershipLoading;

          if (currentPage < 2) {
            return Row(
              mainAxisAlignment: currentPage == 0
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              children: [
                if (currentPage > 0)
                  Expanded(
                    child: CustomOutlinedButton(
                      text: 'السابق',
                      onPressed: () {
                        pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      borderColor: AppColors.primaryNavy,
                      textColor: AppColors.primaryNavy,
                    ),
                  ),
                if (currentPage > 0) SizedBox(width: 12.w),
                PrimaryButton(
                  isLoading: isLoading,
                  width: currentPage == 0 ? 300.w : 200.w, // تنسيق العرض حسب الصفحة
                  text: 'التالي',
                  onPressed: () {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  backgroundColor: AppColors.primaryNavy,
                ),
              ],
            );
          } else {
            return Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    text: 'قبول',
                    backgroundColor: AppColors.primaryNavy,
                    onPressed: onApprove,
                    isLoading: isLoading,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: CustomOutlinedButton(
                    text: 'رفض',
                    onPressed: onReject,
                    borderColor: AppColors.accentRed,
                    textColor: AppColors.accentRed,
                    backgroundColor: AppColors.accentRed.withValues(alpha: .05),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
