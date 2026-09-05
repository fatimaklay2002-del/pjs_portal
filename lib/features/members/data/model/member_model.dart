
import '../../../../core/models/address_edu_info.dart';
import '../../../../core/models/documents_urls.dart';
import '../../../../core/models/personal_info.dart';
import '../../../../core/models/professional_info.dart';

class MemberModel {
  final String id;
  final String email;
  final String fullNameAr;
  final String fullNameEn;
  final String? idPassportNumber;
  final String? phoneNumber;
  final String role;
  final String? membershipType;
  final String? fcmToken;
  final PersonalInfo personalInfo;
  final AddressEduInfo addressInfo;
  final ProfessionalInfo professionalInfo;
  final DocumentsUrls documentsUrls;
  final DateTime createdAt;

  const MemberModel({
    required this.id,
    required this.email,
    required this.fullNameAr,
    required this.fullNameEn,
    this.idPassportNumber,
    this.phoneNumber,
    required this.role,
    this.membershipType,
    this.fcmToken,
    required this.personalInfo,
    required this.addressInfo,
    required this.professionalInfo,
    required this.documentsUrls,
    required this.createdAt,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    final details = json['member_details'] as Map<String, dynamic>? ?? const {};
    return MemberModel(
      id: json['id'] as String,
      email: json['email'] as String,
      fullNameAr: json['full_name_ar'] as String? ?? '',
      fullNameEn: json['full_name_en'] as String? ?? '',
      idPassportNumber: json['id_passport_number'] as String?,
      phoneNumber: json['phone_number'] as String?,
      role: json['role'] as String? ?? 'journalist',
      membershipType: json['membership_type'] as String?,
      fcmToken: json['fcm_token'] as String?,
      personalInfo: PersonalInfo.fromJson(
          (details['personal_info'] as Map<String, dynamic>?) ?? const {}),
      addressInfo: AddressEduInfo.fromJson(
          (details['address_info'] as Map<String, dynamic>?) ?? const {}),
      professionalInfo: ProfessionalInfo.fromJson(
          (details['professional_info'] as Map<String, dynamic>?) ?? const {}),
      documentsUrls: DocumentsUrls.fromJson(
          (details['documents_urls'] as Map<String, dynamic>?) ?? const {}),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toMembersJson() {
    return {
      'full_name_ar': fullNameAr,
      'full_name_en': fullNameEn,
      'id_passport_number': idPassportNumber,
      'phone_number': phoneNumber,
      'role': role,
      'membership_type': membershipType,
      'fcm_token': fcmToken,
    };
  }

  Map<String, dynamic> toMemberDetailsJson() {
    return {
      'personal_info': personalInfo.toJson(),
      'address_info': addressInfo.toJson(),
      'professional_info': professionalInfo.toJson(),
      'documents_urls': documentsUrls.toJson(),
    };
  }

  MemberModel copyWith({
    String? fullNameAr,
    String? fullNameEn,
    String? phoneNumber,
    String? membershipType,
    String? role,
    PersonalInfo? personalInfo,
    AddressEduInfo? addressInfo,
    ProfessionalInfo? professionalInfo,
    DocumentsUrls? documentsUrls,
  }) => MemberModel(
    id: id,
    email: email,
    fullNameAr: fullNameAr ?? this.fullNameAr,
    fullNameEn: fullNameEn ?? this.fullNameEn,
    idPassportNumber: idPassportNumber,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    role: role ?? this.role,
    membershipType: membershipType ?? this.membershipType,
    fcmToken: fcmToken,
    personalInfo: personalInfo ?? this.personalInfo,
    addressInfo: addressInfo ?? this.addressInfo,
    professionalInfo: professionalInfo ?? this.professionalInfo,
    documentsUrls: documentsUrls ?? this.documentsUrls,
    createdAt: createdAt,
  );
}
