
class MembershipFormData {
  // Step 1
  String? fullNameAr;
  String? fullNameEn;
  String? idPassportNumber;
  String? email;
  String? gender;
  String? maritalStatus;
  String? phoneNumber;
  String? alternativePhoneNumber;

  // Step 2
  String? originalCity;
  String? originalGovernorate;
  String? fullAddress;
  String? spouseCity;
  String? spouseGovernorate;
  String? spouseAddress;
  String? universityName;
  String? major;
  String? qualification;
  int? graduationYear;

  // Step 3
  String? mediaOrganization;
  int? workStartYear;
  String? jobType;
  String? workSystem;
  String? organizationAddress;
  String? organizationPhone;
  String? prevJobTitle;
  String? prevJobOrganization;
  String? prevJobStartDate;
  String? prevJobEndDate;

  bool isComplete() {
    return fullNameAr != null &&
        fullNameEn != null &&
        idPassportNumber != null &&
        email != null &&
        gender != null &&
        maritalStatus != null &&
        phoneNumber != null &&
        originalCity != null &&
        originalGovernorate != null &&
        fullAddress != null &&
        universityName != null &&
        major != null &&
        qualification != null &&
        graduationYear != null &&
        mediaOrganization != null &&
        workStartYear != null &&
        jobType != null &&
        workSystem != null &&
        organizationAddress != null &&
        organizationPhone != null;
  }
}
