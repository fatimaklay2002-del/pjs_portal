import 'package:flutter/cupertino.dart';

import '../../data/model/member_update_form_data.dart';

class UpdateStep2Controllers {
  final originalCity = TextEditingController();
  final originalGov = TextEditingController();
  final fullAddress = TextEditingController();
  final spouseCity = TextEditingController();
  final spouseGov = TextEditingController();
  final spouseAddress = TextEditingController();
  final university = TextEditingController();
  final major = TextEditingController();
  final gradYear = TextEditingController();
  final mediaOrg = TextEditingController();
  final workStartYear = TextEditingController();
  final jobType = TextEditingController();
  final orgAddress = TextEditingController();
  final orgPhone = TextEditingController();

  UpdateStep2Controllers(MemberUpdateFormData data) {
    originalCity.text = data.originalCity ?? '';
    originalGov.text = data.originalGov ?? '';
    fullAddress.text = data.fullAddress ?? '';
    spouseCity.text = data.spouseCity ?? '';
    spouseGov.text = data.spouseGov ?? '';
    spouseAddress.text = data.spouseAddress ?? '';
    university.text = data.university ?? '';
    major.text = data.major ?? '';
    gradYear.text = data.gradYear?.toString() ?? '';
    mediaOrg.text = data.mediaOrg ?? '';
    workStartYear.text = data.workStartYear?.toString() ?? '';
    jobType.text = data.jobType ?? '';
    orgAddress.text = data.orgAddress ?? '';
    orgPhone.text = data.orgPhone ?? '';
  }

  void saveInto(MemberUpdateFormData data) {
    data
      ..originalCity = originalCity.text.trim()
      ..originalGov = originalGov.text.trim()
      ..fullAddress = fullAddress.text.trim()
      ..spouseCity = spouseCity.text.trim().isEmpty ? null : spouseCity.text.trim()
      ..spouseGov = spouseGov.text.trim().isEmpty ? null : spouseGov.text.trim()
      ..spouseAddress = spouseAddress.text.trim().isEmpty ? null : spouseAddress.text.trim()
      ..university = university.text.trim()
      ..major = major.text.trim()
      ..gradYear = int.tryParse(gradYear.text)
      ..mediaOrg = mediaOrg.text.trim()
      ..workStartYear = int.tryParse(workStartYear.text)
      ..jobType = jobType.text.trim()
      ..orgAddress = orgAddress.text.trim()
      ..orgPhone = orgPhone.text.trim();
  }

  void dispose() {
    originalCity.dispose();
    originalGov.dispose();
    fullAddress.dispose();
    spouseCity.dispose();
    spouseGov.dispose();
    spouseAddress.dispose();
    university.dispose();
    major.dispose();
    gradYear.dispose();
    mediaOrg.dispose();
    workStartYear.dispose();
    jobType.dispose();
    orgAddress.dispose();
    orgPhone.dispose();
  }
}
