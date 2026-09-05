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
import '../controllers/step2_controllers.dart';


class Step2AddressEducationFields extends StatelessWidget {
  final Step2Controllers controllers;
  final MembershipFormData formData;
  final ValueChanged<String?> onQualificationChanged;

  const Step2AddressEducationFields({
    super.key,
    required this.controllers,
    required this.formData,
    required this.onQualificationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(AppStrings.address, style: AppTextStyles.labelLarge),
        SizedBox(height: 10.h),
        Row(
          children: [
            CustomTextField(
              width: 142.w,
              hint: 'المحافظة الأصلية',
              controller: controllers.originalGovernorate,
              validator: (v) => (v == null || v.isEmpty) ? AppStrings.fieldRequired : null,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: CustomTextField(
                hint: 'المدينة الأصلية',
                controller: controllers.originalCity,
                validator: (v) => (v == null || v.isEmpty) ? AppStrings.fieldRequired : null,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        CustomTextField(
          hint: 'العنوان الأصلي كامل',
          controller: controllers.fullAddress,
          validator: (v) => (v == null || v.isEmpty) ? AppStrings.fieldRequired : null,
        ),
        SizedBox(height: 20.h),
        Text(AppStrings.spouse, style: AppTextStyles.labelLarge),
        Row(
          children: [
            CustomTextField(
              width: 142.w,
              hint: 'محافظة النزوح',
              controller: controllers.spouseCity,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: CustomTextField(
                hint: 'مدينة النزوح',
                controller: controllers.spouseGovernorate,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        CustomTextField(hint: 'عنوان النزوح كامل', controller: controllers.spouseAddress),
        SizedBox(height: 20.h),
        CustomTextField(
          label: AppStrings.universityName,
          hint: AppStrings.enterUniversityName,
          icon: Icon(Icons.school_rounded, color: AppColors.lightGrey, size: 20.w),
          controller: controllers.university,
          validator: (v) => (v == null || v.isEmpty) ? AppStrings.fieldRequired : null,
        ),
        SizedBox(height: 20.h),
        CustomTextField(
          label: AppStrings.major,
          hint: AppStrings.enterMajor,
          icon: SvgPicture.asset('assets/icons/icon_major.svg', height: 18.h, width: 18.h),
          controller: controllers.major,
          validator: (v) => (v == null || v.isEmpty) ? AppStrings.fieldRequired : null,
        ),
        SizedBox(height: 20.h),
        CustomDropdownField(
          label: AppStrings.qualification,
          hint: AppStrings.selectQualification,
          icon: SvgPicture.asset('assets/icons/qualification_icon.svg', height: 18.h, width: 18.h),
          items: sortedOptions([
            AppStrings.diploma,
            AppStrings.bachelor,
            AppStrings.master,
            AppStrings.phd,
          ]),
          value: formData.qualification,
          onChanged: onQualificationChanged,
          validator: (v) => (v == null || v.isEmpty) ? AppStrings.fieldRequired : null,
        ),
        SizedBox(height: 20.h),
        CustomTextField(
          label: AppStrings.graduationYear,
          hint: AppStrings.enterGraduationYear,
          icon: SvgPicture.asset("assets/icons/date_icon.svg", height: 18.h, width: 18.h),
          controller: controllers.graduationYear,
          keyboardType: TextInputType.number,
          validator: (v) {
            if (v == null || v.isEmpty) return AppStrings.fieldRequired;
            if (int.tryParse(v) == null) return 'يرجى إدخال سنة صحيحة';
            return null;
          },
        ),
        SizedBox(height: 40.h),
      ],
    );
  }
}
