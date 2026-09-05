import '../../../core/models/address_edu_info.dart';
import '../../../core/models/documents_urls.dart';
import '../../../core/models/personal_info.dart';
import '../../../core/models/professional_info.dart';
import '../data/model/membership_request_model.dart';
import 'membership_form_data.dart';


extension MembershipFormMapper on MembershipFormData {
  MembershipRequestModel toRequestModel(DocumentsUrls documentsUrls) {
    return MembershipRequestModel(
      fullNameAr: fullNameAr!,
      fullNameEn: fullNameEn!,
      idPassportNumber: idPassportNumber!,
      email: email!,
      phoneNumber: phoneNumber!,
      personalInfo: PersonalInfo(
        gender: gender!,
        maritalStatus: maritalStatus!,
        alternativePhoneNumber: alternativePhoneNumber,
      ),
      addressInfo: AddressEduInfo(
        originalCity: originalCity!,
        originalGovernorate: originalGovernorate!,
        fullAddress: fullAddress!,
        spouseCity: spouseCity,
        spouseGovernorate: spouseGovernorate,
        spouseAddress: spouseAddress,
        universityName: universityName!,
        major: major!,
        qualification: qualification!,
        graduationYear: graduationYear!,
      ),
      professionalInfo: ProfessionalInfo(
        mediaOrganization: mediaOrganization!,
        workStartYear: workStartYear!,
        jobType: jobType!,
        workSystem: workSystem!,
        organizationAddress: organizationAddress!,
        organizationPhone: organizationPhone!,
        prevJobTitle: prevJobTitle,
        prevJobOrganization: prevJobOrganization,
        prevJobStartDate: prevJobStartDate,
        prevJobEndDate: prevJobEndDate,
      ),
      documentsUrls: documentsUrls,
    );
  }
}
