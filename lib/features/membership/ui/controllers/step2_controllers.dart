import 'package:flutter/material.dart';
import '../../logic/membership_form_data.dart';

class Step2Controllers {
  final originalCity = TextEditingController();
  final originalGovernorate = TextEditingController();
  final fullAddress = TextEditingController();
  final spouseCity = TextEditingController();
  final spouseGovernorate = TextEditingController();
  final spouseAddress = TextEditingController();
  final university = TextEditingController();
  final major = TextEditingController();
  final graduationYear = TextEditingController();

  Step2Controllers(MembershipFormData data) {
    originalCity.text = data.originalCity ?? '';
    originalGovernorate.text = data.originalGovernorate ?? '';
    fullAddress.text = data.fullAddress ?? '';
    spouseCity.text = data.spouseCity ?? '';
    spouseGovernorate.text = data.spouseGovernorate ?? '';
    spouseAddress.text = data.spouseAddress ?? '';
    university.text = data.universityName ?? '';
    major.text = data.major ?? '';
    graduationYear.text = data.graduationYear?.toString() ?? '';
  }

  void saveInto(MembershipFormData data) {
    data
      ..originalCity = originalCity.text
      ..originalGovernorate = originalGovernorate.text
      ..fullAddress = fullAddress.text
      ..spouseCity = spouseCity.text.isEmpty ? null : spouseCity.text
      ..spouseGovernorate =
          spouseGovernorate.text.isEmpty ? null : spouseGovernorate.text
      ..spouseAddress = spouseAddress.text.isEmpty ? null : spouseAddress.text
      ..universityName = university.text
      ..major = major.text
      ..graduationYear = int.tryParse(graduationYear.text);
  }

  void dispose() {
    originalCity.dispose();
    originalGovernorate.dispose();
    fullAddress.dispose();
    spouseCity.dispose();
    spouseGovernorate.dispose();
    spouseAddress.dispose();
    university.dispose();
    major.dispose();
    graduationYear.dispose();
  }
}
