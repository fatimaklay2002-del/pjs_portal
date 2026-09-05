
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/Constants/app_strings.dart';
import '../../../../../../core/widgets/custom_outlined_button.dart';
import '../../../../../../core/widgets/primary_button.dart';
import '../../../../data/model/member_model.dart';
import '../../../controllers/update_step3_controllers.dart';
import '../shared/page3_documents_section.dart';
import '../shared/page3_previous_job_section.dart';
class UpdateStep3JobsAttachments extends StatefulWidget {
  final MemberModel member;
  final UpdateStep3Controllers controllers;
  final bool isLoading;
  final VoidCallback onPrev;
  final VoidCallback onSubmit;
  final PlatformFile? personalPhoto, idPassportPhoto, bankStatement,
      universityDegree, syndicateCard, employmentContract, mediaLicense;
  final ValueChanged<PlatformFile> onPersonalPhoto, onIdPassportPhoto,
      onBankStatement, onUniversityDegree, onSyndicateCard,
      onEmploymentContract, onMediaLicense;

  const UpdateStep3JobsAttachments({
    super.key,
    required this.member,
    required this.controllers,
    required this.isLoading,
    required this.onPrev,
    required this.onSubmit,
    this.personalPhoto, this.idPassportPhoto, this.bankStatement,
    this.universityDegree, this.syndicateCard, this.employmentContract,
    this.mediaLicense,
    required this.onPersonalPhoto, required this.onIdPassportPhoto,
    required this.onBankStatement, required this.onUniversityDegree,
    required this.onSyndicateCard, required this.onEmploymentContract,
    required this.onMediaLicense,
  });

  @override
  State<UpdateStep3JobsAttachments> createState() => _UpdateStep3JobsAttachmentsState();
}

class _UpdateStep3JobsAttachmentsState extends State<UpdateStep3JobsAttachments> {
  Future<void> _pickFile(ValueChanged<PlatformFile> onPicked) async {
    final file = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],

    );
    if (file == null) return;
    onPicked(file);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Page3PreviousJobSection(
            titleCtrl: widget.controllers.prevJobTitle,
            orgCtrl: widget.controllers.prevJobOrg,
            startCtrl: widget.controllers.prevJobStart,
            endCtrl: widget.controllers.prevJobEnd,
          ),
          SizedBox(height: 12.h),
          Page3DocumentsSection(
            existing: widget.member.documentsUrls,
            personalPhoto: widget.personalPhoto,
            idPassportPhoto: widget.idPassportPhoto,
            bankStatement: widget.bankStatement,
            universityDegree: widget.universityDegree,
            syndicateCard: widget.syndicateCard,
            employmentContract: widget.employmentContract,
            mediaLicense: widget.mediaLicense,
            onPick: _pickFile,
            onPersonalPhoto: widget.onPersonalPhoto,
            onIdPassportPhoto: widget.onIdPassportPhoto,
            onBankStatement: widget.onBankStatement,
            onUniversityDegree: widget.onUniversityDegree,
            onSyndicateCard: widget.onSyndicateCard,
            onEmploymentContract: widget.onEmploymentContract,
            onMediaLicense: widget.onMediaLicense,
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(child: CustomOutlinedButton(onPressed: widget.onPrev, text: AppStrings.back)),
              SizedBox(width: 12.w),
              Expanded(
                child: PrimaryButton(
                  text: AppStrings.update,
                  onPressed: widget.onSubmit,
                  isLoading: widget.isLoading,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
