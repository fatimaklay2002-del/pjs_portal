import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pjs_portal/core/widgets/primary_button.dart';
import 'package:pjs_portal/features/members/ui/widgets/member_update_data_steps/shared/dropdown_row.dart';
import 'package:pjs_portal/features/members/ui/widgets/member_update_data_steps/shared/edit_row.dart';
import '../../../../../../core/Constants/app_strings.dart';
import '../../../../../../core/theme/app_color.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/widgets/dropdown_options.dart';
import '../../../../../admin/ui/widgets/request_review_widgets/request_review_widgets.dart';
import '../../../../data/model/member_model.dart';
import '../../../controllers/update_step1_controllers.dart';


class UpdateStep1PersonalInfo extends StatelessWidget {
  final MemberModel member;
  final UpdateStep1Controllers controllers;
  final String gender, maritalStatus;
  final ValueChanged<String?> onGenderChanged, onMaritalChanged;
  final VoidCallback onNext;

  const UpdateStep1PersonalInfo({
    super.key,
    required this.member,
    required this.controllers,
    required this.gender,
    required this.maritalStatus,
    required this.onGenderChanged,
    required this.onMaritalChanged,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 36.r,
                  backgroundColor: AppColors.lightNavy.withValues(alpha: .15),
                  child: Icon(Icons.sync, color: AppColors.primaryNavy, size: 32.w),
                ),
                SizedBox(height: 8.h),
                Text(member.fullNameAr, style: AppTextStyles.headlineSmall),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.lightNavy.withValues(alpha: .15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('تحديث', style: AppTextStyles.labelMedium.copyWith(color: AppColors.primaryNavy)),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          SectionCard(
            title: AppStrings.personalInfo,
            icon: SvgPicture.asset("assets/icons/id_icon.svg", colorFilter: ColorFilter.mode(AppColors.lightNavy, BlendMode.modulate)),
            child: Column(
              children: [
                EditRow(label: AppStrings.fullNameArabic, controller: controllers.fullNameAr),
                EditRow(label: AppStrings.fullNameEnglish, controller: controllers.fullNameEn),
                EditRow(label: AppStrings.idPassportNumber, controller: controllers.idNumber),
                EditRow(label: AppStrings.email, controller: TextEditingController(text: member.email), enabled: false),
                DropdownRow(label: AppStrings.gender, value: gender, items: sortedOptions([AppStrings.male, AppStrings.female]), onChanged: onGenderChanged),
                DropdownRow(label: AppStrings.maritalStatus, value: maritalStatus, items: sortedOptions([AppStrings.single, AppStrings.married, AppStrings.divorced]), onChanged: onMaritalChanged),
                EditRow(label: AppStrings.phoneNumber, controller: controllers.phone, keyboardType: TextInputType.phone),
                EditRow(label: AppStrings.alternativePhoneNumber, controller: controllers.altPhone, keyboardType: TextInputType.phone),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          PrimaryButton(text: AppStrings.next, onPressed: onNext),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
