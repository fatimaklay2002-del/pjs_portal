import '../../../../core/models/address_edu_info.dart';
import '../../../../core/models/documents_urls.dart';
import '../../../../core/models/personal_info.dart';
import '../../../../core/models/professional_info.dart';

class MembershipRequestModel {
  final String? id;
  final String fullNameAr;
  final String fullNameEn;
  final String idPassportNumber;
  final String email;
  final String phoneNumber;
  final PersonalInfo personalInfo;
  final AddressEduInfo addressInfo;
  final ProfessionalInfo professionalInfo;
  final DocumentsUrls documentsUrls;
  final String status;
  final DateTime? createdAt;

  const MembershipRequestModel({
    this.id,
    required this.fullNameAr,
    required this.fullNameEn,
    required this.idPassportNumber,
    required this.email,
    required this.phoneNumber,
    required this.personalInfo,
    required this.addressInfo,
    required this.professionalInfo,
    required this.documentsUrls,
    this.status = 'pending',
    this.createdAt,
  });

  /// Writable columns only — `created_at`/`status` default on the DB side.
  Map<String, dynamic> toJson() => {
    'full_name_ar': fullNameAr,
    'full_name_en': fullNameEn,
    'id_passport_number': idPassportNumber,
    'email': email,
    'phone_number': phoneNumber,
    'personal_info': personalInfo.toJson(),
    'address_info': addressInfo.toJson(),
    'professional_info': professionalInfo.toJson(),
    'documents_urls': documentsUrls.toJson(),
  };

  factory MembershipRequestModel.fromJson(Map<String, dynamic> json) {
    return MembershipRequestModel(
      id: json['id'] as String?,
      fullNameAr: json['full_name_ar'] as String,
      fullNameEn: json['full_name_en'] as String,
      idPassportNumber: json['id_passport_number'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String,
      personalInfo: PersonalInfo.fromJson(
          (json['personal_info'] as Map<String, dynamic>?) ?? const {}),
      addressInfo: AddressEduInfo.fromJson(
          (json['address_info'] as Map<String, dynamic>?) ?? const {}),
      professionalInfo: ProfessionalInfo.fromJson(
          (json['professional_info'] as Map<String, dynamic>?) ?? const {}),
      documentsUrls: DocumentsUrls.fromJson(
          (json['documents_urls'] as Map<String, dynamic>?) ?? const {}),
      status: json['status'] as String? ?? 'pending',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }
}
