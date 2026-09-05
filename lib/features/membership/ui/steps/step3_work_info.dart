import 'package:flutter/material.dart';
import 'package:pjs_portal/features/membership/ui/controllers/step3_controllers.dart';

import 'package:pjs_portal/features/membership/ui/widgets/step_wrapper.dart';

import '../../logic/membership_form_data.dart';
import '../widgets/step3_work_info_fields.dart';
class Step3WorkInfo extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final MembershipFormData formData;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const Step3WorkInfo({
    super.key,
    required this.formKey,
    required this.formData,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  State<Step3WorkInfo> createState() => _Step3WorkInfoState();
}

class _Step3WorkInfoState extends State<Step3WorkInfo> {
  late final controllers = Step3Controllers(widget.formData);

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
        child: Step3WorkInfoFields(
          controllers: controllers,
          formData: widget.formData,
          onWorkSystemChanged: (v) =>
              setState(() => widget.formData.workSystem = v),
        ),
      ),
    );
  }
}
