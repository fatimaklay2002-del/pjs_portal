import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pjs_portal/features/members/ui/widgets/member_update_data_steps/shared/update_attachment_row.dart';
import '../../../../../../core/Constants/app_strings.dart';
import '../../../../../../core/models/documents_urls.dart';
import '../../../../../admin/ui/widgets/request_review_widgets/request_review_widgets.dart';

class Page3DocumentsSection extends StatelessWidget {
  final DocumentsUrls existing;
  final PlatformFile? personalPhoto, idPassportPhoto, bankStatement,
      universityDegree, syndicateCard, employmentContract, mediaLicense;
  final void Function(ValueChanged<PlatformFile> onPicked) onPick;
  final ValueChanged<PlatformFile> onPersonalPhoto, onIdPassportPhoto,
      onBankStatement, onUniversityDegree, onSyndicateCard,
      onEmploymentContract, onMediaLicense;

  const Page3DocumentsSection({
    super.key,
    required this.existing,
    this.personalPhoto, this.idPassportPhoto, this.bankStatement,
    this.universityDegree, this.syndicateCard, this.employmentContract,
    this.mediaLicense,
    required this.onPick,
    required this.onPersonalPhoto, required this.onIdPassportPhoto,
    required this.onBankStatement, required this.onUniversityDegree,
    required this.onSyndicateCard, required this.onEmploymentContract,
    required this.onMediaLicense,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      icon: const Icon(Icons.attach_file),
      title: AppStrings.documents,
      child: Column(
        children: [
          AttachmentRow(label: AppStrings.personalPhoto, existingUrl: existing.personalPhoto, newFile: personalPhoto, onTap: () => onPick(onPersonalPhoto)),
          AttachmentRow(label: AppStrings.idPassportPhoto, existingUrl: existing.idPassportPhoto, newFile: idPassportPhoto, onTap: () => onPick(onIdPassportPhoto)),
          AttachmentRow(label: AppStrings.bankAccountStatement, existingUrl: existing.bankStatement, newFile: bankStatement, onTap: () => onPick(onBankStatement)),
          AttachmentRow(label: AppStrings.universityDegree, existingUrl: existing.universityDegree, newFile: universityDegree, onTap: () => onPick(onUniversityDegree)),
          AttachmentRow(label: AppStrings.syndicateCard, existingUrl: existing.syndicateCard, newFile: syndicateCard, onTap: () => onPick(onSyndicateCard)),
          AttachmentRow(label: AppStrings.employmentContract, existingUrl: existing.employmentContract, newFile: employmentContract, onTap: () => onPick(onEmploymentContract)),
          AttachmentRow(label: AppStrings.mediaLicense, existingUrl: existing.mediaLicense, newFile: mediaLicense, onTap: () => onPick(onMediaLicense)),
        ],
      ),
    );
  }
}
