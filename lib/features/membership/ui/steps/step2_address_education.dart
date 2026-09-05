import 'package:flutter/material.dart';

import 'package:pjs_portal/features/membership/ui/widgets/step2_address_education_fields.dart';
import 'package:pjs_portal/features/membership/ui/widgets/step_wrapper.dart';


import '../../logic/membership_form_data.dart';
import '../controllers/step2_controllers.dart';

class Step2AddressEducation extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final MembershipFormData formData;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const Step2AddressEducation({
    super.key,
    required this.formKey,
    required this.formData,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  State<Step2AddressEducation> createState() => _Step2AddressEducationState();
}

class _Step2AddressEducationState extends State<Step2AddressEducation> {
  late final controllers = Step2Controllers(widget.formData);

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
      onNextArrow: _saveAndNext,
      onPreviousArrow: widget.onPrevious,
      child: Form(
        key: widget.formKey,
        child: Step2AddressEducationFields(
          controllers: controllers,
          formData: widget.formData,
          onQualificationChanged: (v) =>
              setState(() => widget.formData.qualification = v),
        ),
      ),
    );
  }
}
