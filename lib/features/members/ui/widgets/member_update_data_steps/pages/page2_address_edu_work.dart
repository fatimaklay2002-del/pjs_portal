import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pjs_portal/core/Constants/app_strings.dart';

import 'package:pjs_portal/features/members/ui/widgets/member_update_data_steps/shared/dropdown_row.dart';
import 'package:pjs_portal/features/members/ui/widgets/member_update_data_steps/shared/edit_row.dart';

import '../../../../../../core/theme/app_color.dart';
import '../../../../../../core/widgets/custom_outlined_button.dart';
import '../../../../../../core/widgets/dropdown_options.dart';
import '../../../../../../core/widgets/primary_button.dart';
import '../../../../../admin/ui/widgets/request_review_widgets/request_review_widgets.dart';
import '../../../controllers/update_step2_controllers.dart';
class UpdateStep2AddressEduWork extends StatelessWidget {
  final UpdateStep2Controllers controllers;
  final String qualification, workSystem;
  final ValueChanged<String?> onQualificationChanged, onWorkSystemChanged;
  final VoidCallback onPrev, onNext;

  const UpdateStep2AddressEduWork({
    super.key,
    required this.controllers,
    required this.qualification,
    required this.workSystem,
    required this.onQualificationChanged,
    required this.onWorkSystemChanged,
    required this.onPrev,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          SectionCard(
            icon: Icon(Icons.location_on, color: AppColors.lightNavy),
            title: AppStrings.address,
            child: Column(
              children: [
                EditRow(label: AppStrings.originalGovernorate, controller: controllers.originalGov),
                EditRow(label: AppStrings.originalCity, controller: controllers.originalCity),
                EditRow(label: AppStrings.fullAddress, controller: controllers.fullAddress),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          SectionCard(
            icon: const Icon(Icons.location_on_outlined),
            title: AppStrings.spouse,
            child: Column(
              children: [
                EditRow(label: AppStrings.spouseGovernorate, controller: controllers.spouseGov),
                EditRow(label: AppStrings.spouseCity, controller: controllers.spouseCity),
                EditRow(label: AppStrings.spouseAddress, controller: controllers.spouseAddress),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          SectionCard(
            icon: const Icon(Icons.school_outlined),
            title: AppStrings.education,
            child: Column(
              children: [
                EditRow(label: AppStrings.universityName, controller: controllers.university),
                EditRow(label: AppStrings.major, controller: controllers.major),
                DropdownRow(
                  label: AppStrings.qualification,
                  value: qualification,
                  items: sortedOptions([AppStrings.diploma, AppStrings.bachelor, AppStrings.master, AppStrings.phd]),
                  onChanged: onQualificationChanged,
                ),
                EditRow(label: AppStrings.graduationYear, controller: controllers.gradYear, keyboardType: TextInputType.number),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          SectionCard(
            icon: const Icon(Icons.work_outline),
            title: AppStrings.workInfo,
            child: Column(
              children: [
                EditRow(label: AppStrings.mediaOrganization, controller: controllers.mediaOrg),
                EditRow(label: AppStrings.workStartYear, controller: controllers.workStartYear, keyboardType: TextInputType.number),
                EditRow(label: AppStrings.jobType, controller: controllers.jobType),
                DropdownRow(
                  label: AppStrings.workSystem,
                  value: workSystem,
                  items: sortedOptions([AppStrings.fullTime, AppStrings.partTime]),
                  onChanged: onWorkSystemChanged,
                ),
                EditRow(label: AppStrings.organizationAddress, controller: controllers.orgAddress),
                EditRow(label: AppStrings.organizationPhone, controller: controllers.orgPhone, keyboardType: TextInputType.phone),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(child: CustomOutlinedButton(onPressed: onPrev, text: AppStrings.back)),
              SizedBox(width: 12.w),
              Expanded(child: PrimaryButton(text: AppStrings.next, onPressed: onNext)),
            ],
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
