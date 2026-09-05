import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pjs_portal/features/admin/ui/widgets/request_review_widgets/request_review_widgets.dart';
import '../../../../../core/Constants/app_strings.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../membership/data/model/membership_request_model.dart';

class ReviewPage1 extends StatelessWidget {
  final MembershipRequestModel request;

  const ReviewPage1({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          // Avatar
          Container(
            width: 78.w,
            height: 76.w,
            decoration: BoxDecoration(
              color: AppColors.lightNavy.withValues(alpha: .15),
              borderRadius: BorderRadius.circular(50.r),
              border: Border.all(color: AppColors.white, width: 4),
            ),
            child: Center(
              child: Icon(
                Icons.person_add,
                size: 24,
                color: AppColors.primaryNavy,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(request.fullNameAr, style: AppTextStyles.titleLarge),
          SizedBox(height: 6.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.lightNavy.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              'قيد المراجعة',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primaryNavy,
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // Personal Info Section
          SectionCard(
            title: AppStrings.personalInfo,
            icon: SvgPicture.asset(
              "assets/icons/id_icon.svg",
              colorFilter: ColorFilter.mode(
                AppColors.primaryNavy,
                BlendMode.srcIn,
              ),
              width: 24.w,
              height: 24.h,
            ),
            child: Column(
              children: [
                InfoRow(
                  label: AppStrings.fullNameArabic,
                  value: request.fullNameAr,
                ),
                InfoRow(
                  label: AppStrings.fullNameEnglish,
                  value: request.fullNameEn,
                ),
                InfoRow(
                  label: AppStrings.idPassportNumber,
                  value: request.idPassportNumber,
                ),
                InfoRow(label: AppStrings.email, value: request.email),
                InfoRow(label: AppStrings.gender, value: request.personalInfo.gender),
                InfoRow(
                  label: AppStrings.maritalStatus,
                  value: request.personalInfo.maritalStatus,
                ),
                InfoRow(
                  label: AppStrings.phoneNumber,
                  value: request.phoneNumber,
                ),
                if (request.personalInfo.alternativePhoneNumber != null)
                  InfoRow(
                    label: AppStrings.alternativePhoneNumber,
                    value: request.personalInfo.alternativePhoneNumber!,
                  ),
              ],
            ),
          ),
          SizedBox(height: 10.h),

          // Address Section
          SectionCard(
            title: AppStrings.address,
            icon: Icon(Icons.location_on, color: AppColors.lightNavy),
            child: Column(
              children: [
                InfoRow(
                  label: AppStrings.originalGovernorate,
                  value: request.addressInfo.originalGovernorate,
                ),
                InfoRow(
                  label: AppStrings.originalCity,
                  value: request.addressInfo.originalCity,
                ),
                InfoRow(
                  label: AppStrings.fullAddress,
                  value: request.addressInfo.fullAddress,
                ),
                if (request.addressInfo.spouseGovernorate != null) ...[
                  InfoRow(
                    label: AppStrings.spouseGovernorate,
                    value: request.addressInfo.spouseGovernorate ?? '',
                  ),
                  InfoRow(
                    label: AppStrings.spouseCity,
                    value: request.addressInfo.spouseCity ?? '',
                  ),
                  InfoRow(
                    label: AppStrings.spouseAddress,
                    value: request.addressInfo.spouseAddress ?? '',
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}