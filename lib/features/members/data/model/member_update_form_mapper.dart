import '../../../../core/models/address_edu_info.dart';
import '../../../../core/models/personal_info.dart';
import '../../../../core/models/professional_info.dart';
import 'member_update_form_data.dart';


extension MemberUpdateFormMapper on MemberUpdateFormData {
  PersonalInfo toPersonalInfo() => PersonalInfo(
        gender: gender!,
        maritalStatus: maritalStatus!,
        alternativePhoneNumber: altPhone,
      );

  AddressEduInfo toAddressInfo() => AddressEduInfo(
        originalCity: originalCity!,
        originalGovernorate: originalGov!,
        fullAddress: fullAddress!,
        spouseCity: spouseCity,
        spouseGovernorate: spouseGov,
        spouseAddress: spouseAddress,
        universityName: university!,
        major: major!,
        qualification: qualification!,
        graduationYear: gradYear!,
      );

  ProfessionalInfo toProfessionalInfo() => ProfessionalInfo(
        mediaOrganization: mediaOrg!,
        workStartYear: workStartYear!,
        jobType: jobType!,
        workSystem: workSystem!,
        organizationAddress: orgAddress!,
        organizationPhone: orgPhone!,
        prevJobTitle: prevJobTitle,
        prevJobOrganization: prevJobOrg,
        prevJobStartDate: prevJobStart,
        prevJobEndDate: prevJobEnd,
      );
}
