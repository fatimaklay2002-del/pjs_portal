import 'package:flutter/material.dart';

import '../../logic/membership_form_data.dart';

class Step1Controllers {
  final fullNameAr = TextEditingController();
  final fullNameEn = TextEditingController();
  final idNumber = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final altPhone = TextEditingController();

  Step1Controllers(MembershipFormData data) {
    fullNameAr.text = data.fullNameAr ?? '';
    fullNameEn.text = data.fullNameEn ?? '';
    idNumber.text = data.idPassportNumber ?? '';
    email.text = data.email ?? '';
    phone.text = data.phoneNumber ?? '';
    altPhone.text = data.alternativePhoneNumber ?? '';
  }

  void saveInto(MembershipFormData data) {
    data
      ..fullNameAr = fullNameAr.text
      ..fullNameEn = fullNameEn.text
      ..idPassportNumber = idNumber.text
      ..email = email.text
      ..phoneNumber = phone.text
      ..alternativePhoneNumber = altPhone.text.isEmpty ? null : altPhone.text;
  }

  void dispose() {
    fullNameAr.dispose();
    fullNameEn.dispose();
    idNumber.dispose();
    email.dispose();
    phone.dispose();
    altPhone.dispose();
  }
}
