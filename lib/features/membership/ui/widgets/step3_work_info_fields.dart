import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/Constants/app_strings.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/dropdown_options.dart';
import '../../logic/membership_form_data.dart';
import 'custom_dropdown_field.dart';
import '../controllers/step3_controllers.dart';

class Step3WorkInfoFields extends StatelessWidget {
  final Step3Controllers controllers;
  final MembershipFormData formData;
  final ValueChanged<String?> onWorkSystemChanged;

  const Step3WorkInfoFields({
    super.key,
    required this.controllers,
    required this.formData,
    required this.onWorkSystemChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextField(
          label: AppStrings.mediaOrganization,
          hint: AppStrings.enterOrganizationName,
          icon: SvgPicture.asset('assets/icons/Icons.business.svg', height: 18.h, width: 18.h),
          controller: controllers.mediaOrg,
          validator: (v) => (v == null || v.isEmpty) ? AppStrings.fieldRequired : null,
        ),
        SizedBox(height: 20.h),
        CustomTextField(
          label: AppStrings.workStartYear,
          hint: AppStrings.enterWorkStartYear,
          icon: SvgPicture.asset('assets/icons/date_icon.svg', height: 18.h, width: 18.h),
          controller: controllers.workStartYear,
          keyboardType: TextInputType.number,
          validator: (v) {
            if (v == null || v.isEmpty) return AppStrings.fieldRequired;
            if (int.tryParse(v) == null) return 'يرجى إدخال سنة صحيحة';
            return null;
          },
        ),
        SizedBox(height: 20.h),
        CustomTextField(
          label: AppStrings.jobType,
          hint: AppStrings.enterJobType,
          icon: SvgPicture.asset('assets/icons/Icons.work.svg', height: 18.h, width: 18.h),
          controller: controllers.jobType,
          validator: (v) => (v == null || v.isEmpty) ? AppStrings.fieldRequired : null,
        ),
        SizedBox(height: 20.h),
        CustomDropdownField(
          label: AppStrings.workSystem,
          hint: AppStrings.selectWorkSystem,
          icon: SvgPicture.asset('assets/icons/icons_time.svg', height: 18.h, width: 18.h),
          items: sortedOptions([AppStrings.fullTime, AppStrings.partTime]),
          value: formData.workSystem,
          onChanged: onWorkSystemChanged,
          validator: (v) => (v == null || v.isEmpty) ? AppStrings.fieldRequired : null,
        ),
        SizedBox(height: 20.h),
        CustomTextField(
          label: AppStrings.organizationAddress,
          hint: AppStrings.enterOrganizationAddress,
          icon: SvgPicture.asset('assets/icons/icon_address.svg', height: 18.h, width: 18.h),
          controller: controllers.orgAddress,
          validator: (v) => (v == null || v.isEmpty) ? AppStrings.fieldRequired : null,
        ),
        SizedBox(height: 20.h),
        CustomTextField(
          label: AppStrings.organizationPhone,
          hint: AppStrings.enterOrganizationPhone,
          icon: Icon(Icons.phone_sharp, color: AppColors.lightGrey, size: 20.w),
          controller: controllers.orgPhone,
          keyboardType: TextInputType.phone,
          validator: (v) => (v == null || v.isEmpty) ? AppStrings.fieldRequired : null,
        ),
        SizedBox(height: 10.h),
        Text(AppStrings.previousJobs, style: AppTextStyles.labelLarge),
        SizedBox(height: 10.h),
        Row(
          children: [
            CustomTextField(width: 142.w, hint: AppStrings.endDate, controller: controllers.prevJobEnd),
            SizedBox(width: 10.w),
            Expanded(child: CustomTextField(hint: AppStrings.startDate, controller: controllers.prevJobStart)),
          ],
        ),
        SizedBox(height: 10.h),
        CustomTextField(hint: AppStrings.jobTitle, controller: controllers.prevJobTitle),
        SizedBox(height: 10.h),
        CustomTextField(hint: AppStrings.organization, controller: controllers.prevJobOrg),
        SizedBox(height: 40.h),
      ],
    );
  }
}
