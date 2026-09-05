import '../../../../core/Constants/app_strings.dart';
import 'member_model.dart';

class MemberUpdateFormData {

  String? fullNameAr;
  String? fullNameEn;
  String? idPassportNumber;
  String? phoneNumber;
  String? altPhone;

  String? gender;
  String? maritalStatus;

  String? originalCity;
  String? originalGov;
  String? fullAddress;
  String? spouseCity;
  String? spouseGov;
  String? spouseAddress;
  String? university;
  String? major;
  String? qualification;
  int? gradYear;
  String? mediaOrg;
  int? workStartYear;
  String? jobType;
  String? orgAddress;
  String? orgPhone;
  String? workSystem;

  // Step 3 — professional_info (previous job)
  String? prevJobTitle;
  String? prevJobOrg;
  String? prevJobStart;
  String? prevJobEnd;

  MemberUpdateFormData();

  factory MemberUpdateFormData.fromMember(MemberModel m) {
    final p = m.personalInfo, a = m.addressInfo, w = m.professionalInfo;
    return MemberUpdateFormData()
      ..fullNameAr = m.fullNameAr
      ..fullNameEn = m.fullNameEn
      ..idPassportNumber = m.idPassportNumber
      ..phoneNumber = m.phoneNumber
      ..altPhone = p.alternativePhoneNumber
      ..gender = p.gender.isNotEmpty ? p.gender : AppStrings.male
      ..maritalStatus = p.maritalStatus.isNotEmpty ? p.maritalStatus : AppStrings.single
      ..originalCity = a.originalCity
      ..originalGov = a.originalGovernorate
      ..fullAddress = a.fullAddress
      ..spouseCity = a.spouseCity
      ..spouseGov = a.spouseGovernorate
      ..spouseAddress = a.spouseAddress
      ..university = a.universityName
      ..major = a.major
      ..qualification = a.qualification.isNotEmpty ? a.qualification : AppStrings.bachelor
      ..gradYear = a.graduationYear > 0 ? a.graduationYear : null
      ..mediaOrg = w.mediaOrganization
      ..workStartYear = w.workStartYear > 0 ? w.workStartYear : null
      ..jobType = w.jobType
      ..orgAddress = w.organizationAddress
      ..orgPhone = w.organizationPhone
      ..workSystem = w.workSystem.isNotEmpty ? w.workSystem : AppStrings.fullTime
      ..prevJobTitle = w.prevJobTitle
      ..prevJobOrg = w.prevJobOrganization
      ..prevJobStart = w.prevJobStartDate
      ..prevJobEnd = w.prevJobEndDate;
  }
}
