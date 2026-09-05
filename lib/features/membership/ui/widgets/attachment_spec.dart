import '../../../../core/Constants/app_strings.dart';

class AttachmentSpec {
  final String key;
  final String label;
  final bool required;
  const AttachmentSpec(this.key, this.label, {this.required = false});
}

 List<AttachmentSpec> attachmentSpecs = [
  AttachmentSpec('personal_photos', AppStrings.personalPhoto, required: true),
  AttachmentSpec('id_photos', AppStrings.idPassportPhoto, required: true),
  AttachmentSpec('bank_statements', AppStrings.bankAccountStatement),
  AttachmentSpec('degrees', AppStrings.universityDegree, required: true),
  AttachmentSpec('syndicate_cards', AppStrings.syndicateCard),
  AttachmentSpec('contracts', AppStrings.employmentContract),
  AttachmentSpec('licenses', AppStrings.mediaLicense),
];
