import 'package:flutter/cupertino.dart';

import '../../data/model/member_update_form_data.dart';

class UpdateStep3Controllers {
  final prevJobTitle = TextEditingController();
  final prevJobOrg = TextEditingController();
  final prevJobStart = TextEditingController();
  final prevJobEnd = TextEditingController();

  UpdateStep3Controllers(MemberUpdateFormData data) {
    prevJobTitle.text = data.prevJobTitle ?? '';
    prevJobOrg.text = data.prevJobOrg ?? '';
    prevJobStart.text = data.prevJobStart ?? '';
    prevJobEnd.text = data.prevJobEnd ?? '';
  }

  void saveInto(MemberUpdateFormData data) {
    data
      ..prevJobTitle = prevJobTitle.text.trim().isEmpty ? null : prevJobTitle.text.trim()
      ..prevJobOrg = prevJobOrg.text.trim().isEmpty ? null : prevJobOrg.text.trim()
      ..prevJobStart = prevJobStart.text.trim().isEmpty ? null : prevJobStart.text.trim()
      ..prevJobEnd = prevJobEnd.text.trim().isEmpty ? null : prevJobEnd.text.trim();
  }

  void dispose() {
    prevJobTitle.dispose();
    prevJobOrg.dispose();
    prevJobStart.dispose();
    prevJobEnd.dispose();
  }
}
