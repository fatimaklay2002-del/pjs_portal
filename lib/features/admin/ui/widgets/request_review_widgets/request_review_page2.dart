import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pjs_portal/features/admin/ui/widgets/request_review_widgets/request_review_widgets.dart';

import '../../../../../core/Constants/app_strings.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../membership/data/model/membership_request_model.dart';

class ReviewPage2 extends StatelessWidget {
  final MembershipRequestModel request;

  const ReviewPage2({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Education Section
          SectionCard(
            title: AppStrings.education,
            icon: Icon(Icons.school_rounded, color: AppColors.lightNavy),
            child: Column(
              children: [
                InfoRow(
                  label: AppStrings.universityName,
                  value: request.addressInfo.universityName,
                ),
                InfoRow(label: AppStrings.major, value: request.addressInfo.major),
                InfoRow(
                  label: AppStrings.qualification,
                  value: request.addressInfo.qualification,
                ),
                InfoRow(
                  label: AppStrings.graduationYear,
                  value: request.addressInfo.graduationYear.toString(),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),

          // Work Info Section
          SectionCard(
            title: AppStrings.workInfo,
            icon: Icon(Icons.work_outline, color: AppColors.lightNavy),
            child: Column(
              children: [
                InfoRow(
                  label: AppStrings.organization,
                  value: request.professionalInfo.mediaOrganization,
                ),
                InfoRow(
                  label: AppStrings.workStartYear,
                  value: request.professionalInfo.workStartYear.toString(),
                ),
                InfoRow(label: AppStrings.jobType, value: request.professionalInfo.jobType),
                InfoRow(
                  label: AppStrings.workSystem,
                  value: request.professionalInfo.workSystem,
                ),
                InfoRow(
                  label: AppStrings.organizationAddress,
                  value: request.professionalInfo.organizationAddress,
                ),
                InfoRow(
                  label: AppStrings.organizationPhone,
                  value: request.professionalInfo.organizationPhone,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Previous Jobs Section
          if (request.professionalInfo.prevJobTitle != null) ...[
            SizedBox(height: 10.h),
            SectionCard(
              title: AppStrings.previousJobs,
              icon: Icon(Icons.history, color: AppColors.lightNavy),
              child: Column(
                children: [
                  InfoRow(label: AppStrings.jobTitle,
                      value: request.professionalInfo.prevJobTitle ?? ''),
                  InfoRow(label: AppStrings.mediaOrganizationName,
                      value: request.professionalInfo.prevJobOrganization ?? ''),
                  InfoRow(label: AppStrings.startDate,
                      value: request.professionalInfo.prevJobStartDate ?? ''),
                  InfoRow(label: AppStrings.endDate,
                      value: request.professionalInfo.prevJobEndDate ?? ''),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}