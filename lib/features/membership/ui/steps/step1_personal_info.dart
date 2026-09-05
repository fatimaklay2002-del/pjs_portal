import 'package:flutter/material.dart';
import 'package:pjs_portal/features/membership/ui/controllers/step1_controllers.dart';
import 'package:pjs_portal/features/membership/ui/widgets/step1_personal_info_fields.dart';
import 'package:pjs_portal/features/membership/ui/widgets/step_wrapper.dart';
import '../../../../core/Constants/app_strings.dart';
import '../../logic/membership_form_data.dart';
class Step1PersonalInfo extends StatefulWidget {
final GlobalKey<FormState> formKey;
final MembershipFormData formData;
final VoidCallback onNext;
final VoidCallback onPrevious;

const Step1PersonalInfo({
super.key,
required this.formKey,
required this.formData,
required this.onNext,
required this.onPrevious,
});

@override
State<Step1PersonalInfo> createState() => _Step1PersonalInfoState();
}

class _Step1PersonalInfoState extends State<Step1PersonalInfo> {
late final controllers = Step1Controllers(widget.formData);

@override
void dispose() {
controllers.dispose();
super.dispose();
}

void _saveAndNext() {
if (!widget.formKey.currentState!.validate()) return;
controllers.saveInto(widget.formData);
widget.onNext();
}

@override
Widget build(BuildContext context) {
return StepWrapper(
title: AppStrings.membershipRequestTitle,
subtitle: AppStrings.membershipRequestSubtitle,
icon: Icons.person_add_alt_1_outlined,
onNextArrow: _saveAndNext,
onPreviousArrow: widget.onPrevious,
child: Form(
key: widget.formKey,
child: Step1PersonalInfoFields(
controllers: controllers,
formData: widget.formData,
onGenderChanged: (v) => setState(() => widget.formData.gender = v),
onMaritalChanged: (v) =>
setState(() => widget.formData.maritalStatus = v),
),
),
);
}
}
