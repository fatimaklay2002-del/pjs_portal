import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pjs_portal/features/admin/ui/widgets/request_review_widgets/request_review_widgets.dart';

import '../../../../../core/Constants/app_strings.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../membership/data/model/membership_request_model.dart';
import 'document_item.dart';

class ReviewPage3 extends StatefulWidget {
  final MembershipRequestModel request;
  final String selectedMembershipType;
  final Function(String role, String type) onRoleChanged;

  const ReviewPage3({
    super.key,
    required this.request,
    required this.selectedMembershipType,
    required this.onRoleChanged,
  });

  @override
  State<ReviewPage3> createState() => _ReviewPage3State();
}

class _ReviewPage3State extends State<ReviewPage3> {
  late String _selectedMembershipType;
  @override
  void initState() {
    super.initState();
    _selectedMembershipType = widget.selectedMembershipType;
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Documents Section
          SectionCard(
            title: AppStrings.documents,
            icon: Icon(Icons.attach_file, color: AppColors.lightNavy),
            child: Column(
              children: [
                if (widget.request.documentsUrls.personalPhoto != null)
                  DocumentItem(
                    label: AppStrings.personalPhoto,
                    url: widget.request.documentsUrls.personalPhoto!,
                  ),
                if (widget.request.documentsUrls.idPassportPhoto != null)
                  DocumentItem(
                    label: AppStrings.idPassportPhoto,
                    url: widget.request.documentsUrls.idPassportPhoto!,
                  ),
                if (widget.request.documentsUrls.bankStatement != null)
                  DocumentItem(
                    label: AppStrings.bankAccountStatement,
                    url: widget.request.documentsUrls.bankStatement!,
                  ),
                if (widget.request.documentsUrls.universityDegree != null)
                  DocumentItem(
                    label: AppStrings.universityDegree,
                    url: widget.request.documentsUrls.universityDegree!,
                  ),
                if (widget.request.documentsUrls.syndicateCard != null)
                  DocumentItem(
                    label: AppStrings.syndicateCard,
                    url: widget.request.documentsUrls.syndicateCard!,
                  ),
                if (widget.request.documentsUrls.employmentContract != null)
                  DocumentItem(
                    label: AppStrings.employmentContract,
                    url: widget.request.documentsUrls.employmentContract!,
                  ),
                if (widget.request.documentsUrls.mediaLicense != null)
                  DocumentItem(
                    label: AppStrings.mediaLicense,
                    url: widget.request.documentsUrls.mediaLicense!,
                  ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          _buildMembershipSelection(),
          SizedBox(height: 80.h),
        ],
      ),
    );
  }
  Widget _buildMembershipSelection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.shield_outlined, color: AppColors.primaryNavy, size: 20.sp),
              Text('نوع العضوية', style: AppTextStyles.titleMedium.copyWith(color: AppColors.primaryNavy)),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              _buildTypeChip('عضو مؤقت', 'temporary', Icons.access_time),
              SizedBox(width: 12.w),
              _buildTypeChip('عضو دائم', 'permanent', Icons.verified_user),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypeChip(String label, String value, IconData icon) {
    final isSelected = _selectedMembershipType == value;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => _selectedMembershipType = value);
          widget.onRoleChanged('journalist', value);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.whiteBlue :  AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: isSelected ? AppColors.primaryNavy :  AppColors.whiteBlue),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.primaryNavy, size: 20.sp),
              SizedBox(width: 8.h,),
              Text(label, style: AppTextStyles.labelLarge.copyWith(color: AppColors.primaryNavy)),
            ],
          ),
        ),
      ),
    );
  }

}
