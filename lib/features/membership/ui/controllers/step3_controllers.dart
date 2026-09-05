import 'package:flutter/material.dart';
import '../../logic/membership_form_data.dart';

class Step3Controllers {
  final mediaOrg = TextEditingController();
  final workStartYear = TextEditingController();
  final jobType = TextEditingController();
  final orgAddress = TextEditingController();
  final orgPhone = TextEditingController();
  final prevJobTitle = TextEditingController();
  final prevJobOrg = TextEditingController();
  final prevJobStart = TextEditingController();
  final prevJobEnd = TextEditingController();

  Step3Controllers(MembershipFormData data) {
    mediaOrg.text = data.mediaOrganization ?? '';
    workStartYear.text = data.workStartYear?.toString() ?? '';
    jobType.text = data.jobType ?? '';
    orgAddress.text = data.organizationAddress ?? '';
    orgPhone.text = data.organizationPhone ?? '';
    prevJobTitle.text = data.prevJobTitle ?? '';
    prevJobOrg.text = data.prevJobOrganization ?? '';
    prevJobStart.text = data.prevJobStartDate ?? '';
    prevJobEnd.text = data.prevJobEndDate ?? '';
  }

  void saveInto(MembershipFormData data) {
    data
      ..mediaOrganization = mediaOrg.text
      ..workStartYear = int.tryParse(workStartYear.text)
      ..jobType = jobType.text
      ..organizationAddress = orgAddress.text
      ..organizationPhone = orgPhone.text
      ..prevJobTitle = prevJobTitle.text.isEmpty ? null : prevJobTitle.text.trim()
      ..prevJobOrganization = prevJobOrg.text.isEmpty ? null : prevJobOrg.text.trim()
      ..prevJobStartDate = prevJobStart.text.isEmpty ? null : prevJobStart.text.trim()
      ..prevJobEndDate = prevJobEnd.text.isEmpty ? null : prevJobEnd.text.trim();
  }

  void dispose() {
    mediaOrg.dispose();
    workStartYear.dispose();
    jobType.dispose();
    orgAddress.dispose();
    orgPhone.dispose();
    prevJobTitle.dispose();
    prevJobOrg.dispose();
    prevJobStart.dispose();
    prevJobEnd.dispose();
  }
}
