import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/Constants/app_strings.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/dropdown_options.dart';
import '../../logic/membership_form_data.dart';
import 'custom_dropdown_field.dart';
import '../controllers/step1_controllers.dart';

class Step1PersonalInfoFields extends StatelessWidget {
  final Step1Controllers controllers;
  final MembershipFormData formData;
  final ValueChanged<String?> onGenderChanged;
  final ValueChanged<String?> onMaritalChanged;

  const Step1PersonalInfoFields({
    super.key,
    required this.controllers,
    required this.formData,
    required this.onGenderChanged,
    required this.onMaritalChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextField(
          label: AppStrings.fullNameArabic,
          hint: AppStrings.enterFullNameArabic,
          icon: Icon(Icons.person_sharp, color: AppColors.lightGrey, size: 20.w),
          controller: controllers.fullNameAr,
          validator: (v) => (v == null || v.isEmpty) ? AppStrings.fieldRequired : null,
        ),
        SizedBox(height: 20.h),
        CustomTextField(
          label: AppStrings.fullNameEnglish,
          hint: AppStrings.enterFullNameEnglish,
          icon: Icon(Icons.person_sharp, color: AppColors.lightGrey, size: 20.w),
          controller: controllers.fullNameEn,
          validator: (v) => (v == null || v.isEmpty) ? AppStrings.fieldRequired : null,
        ),
        SizedBox(height: 20.h),
        CustomTextField(
          label: AppStrings.idPassportNumber,
          hint: AppStrings.enterIdNumber,
          icon: SvgPicture.asset('assets/icons/id_icon.svg', height: 18.h, width: 18.h),
          controller: controllers.idNumber,
          keyboardType: TextInputType.number,
          validator: (v) => (v == null || v.isEmpty) ? AppStrings.fieldRequired : null,
        ),
        SizedBox(height: 20.h),
        CustomTextField(
          label: AppStrings.email,
          hint: AppStrings.enterEmail,
          icon: Icon(Icons.email, color: AppColors.lightGrey, size: 20.w),
          controller: controllers.email,
          keyboardType: TextInputType.emailAddress,
          validator: (v) {
            if (v == null || v.isEmpty) return AppStrings.fieldRequired;
            if (!v.contains('@')) return AppStrings.invalidEmail;
            return null;
          },
        ),
        SizedBox(height: 20.h),
        CustomDropdownField(
          label: AppStrings.gender,
          hint: AppStrings.selectGender,
          icon: Icon(Icons.person_sharp, color: AppColors.lightGrey, size: 20.w),
          items: sortedOptions([AppStrings.male, AppStrings.female]),
          value: formData.gender,
          onChanged: onGenderChanged,
          validator: (v) => (v == null || v.isEmpty) ? AppStrings.fieldRequired : null,
        ),
        SizedBox(height: 20.h),
        CustomDropdownField(
          label: AppStrings.maritalStatus,
          hint: AppStrings.selectMaritalStatus,
          icon: Icon(Icons.person_sharp, color: AppColors.lightGrey, size: 20.w),
          items: sortedOptions(
              [AppStrings.single, AppStrings.married, AppStrings.divorced]),
          value: formData.maritalStatus,
          onChanged: onMaritalChanged,
          validator: (v) => (v == null || v.isEmpty) ? AppStrings.fieldRequired : null,
        ),
        SizedBox(height: 20.h),
        CustomTextField(
          label: AppStrings.phoneNumber,
          hint: AppStrings.enterPhoneNumber,
          icon: Icon(Icons.local_phone_rounded, color: AppColors.lightGrey, size: 20.w),
          controller: controllers.phone,
          keyboardType: TextInputType.phone,
          validator: (v) => (v == null || v.isEmpty) ? AppStrings.fieldRequired : null,
        ),
        SizedBox(height: 20.h),
        CustomTextField(
          label: AppStrings.alternativePhoneNumber,
          hint: AppStrings.enterPhoneNumber,
          icon: Icon(Icons.phone_rounded, color: AppColors.lightGrey, size: 20.w),
          controller: controllers.altPhone,
        ),
        SizedBox(height: 40.h),
      ],
    );
  }
}
