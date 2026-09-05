import 'package:flutter/material.dart';

import '../../data/model/member_update_form_data.dart';

class UpdateStep1Controllers {
  final fullNameAr = TextEditingController();
  final fullNameEn = TextEditingController();
  final idNumber = TextEditingController();
  final phone = TextEditingController();
  final altPhone = TextEditingController();

  UpdateStep1Controllers(MemberUpdateFormData data) {
    fullNameAr.text = data.fullNameAr ?? '';
    fullNameEn.text = data.fullNameEn ?? '';
    idNumber.text = data.idPassportNumber ?? '';
    phone.text = data.phoneNumber ?? '';
    altPhone.text = data.altPhone ?? '';
  }

  void saveInto(MemberUpdateFormData data) {
    data
      ..fullNameAr = fullNameAr.text.trim()
      ..fullNameEn = fullNameEn.text.trim()
      ..idPassportNumber = idNumber.text.trim()
      ..phoneNumber = phone.text.trim()
      ..altPhone = altPhone.text.trim().isEmpty ? null : altPhone.text.trim();
  }

  void dispose() {
    fullNameAr.dispose();
    fullNameEn.dispose();
    idNumber.dispose();
    phone.dispose();
    altPhone.dispose();
  }
}