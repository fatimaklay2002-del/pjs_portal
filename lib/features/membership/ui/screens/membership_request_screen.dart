import 'package:flutter/material.dart';
import 'package:pjs_portal/features/membership/ui/steps/step1_personal_info.dart';
import 'package:pjs_portal/features/membership/ui/steps/step2_address_education.dart';
import 'package:pjs_portal/features/membership/ui/steps/step3_work_info.dart';
import 'package:pjs_portal/features/membership/ui/steps/step4_documents.dart';

import '../../../../core/theme/app_color.dart';
import '../../logic/membership_form_data.dart';


class MembershipRequestScreen extends StatefulWidget {
  const MembershipRequestScreen({super.key});

  @override
  State<MembershipRequestScreen> createState() => _MembershipRequestScreenState();
}

class _MembershipRequestScreenState extends State<MembershipRequestScreen> {
  int _currentStep = 0;
  final _formData = MembershipFormData();
  final _formKeys = List.generate(4, (_) => GlobalKey<FormState>());

  void _nextStep() {
    if (_currentStep < 3) setState(() => _currentStep++);
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: SingleChildScrollView(child: _buildStepContent())),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return Step1PersonalInfo(
            formKey: _formKeys[0], formData: _formData, onNext: _nextStep, onPrevious: _previousStep);
      case 1:
        return Step2AddressEducation(
            formKey: _formKeys[1], formData: _formData, onNext: _nextStep, onPrevious: _previousStep);
      case 2:
        return Step3WorkInfo(
            formKey: _formKeys[2], formData: _formData, onNext: _nextStep, onPrevious: _previousStep);
      case 3:
        return Step4Documents(
            formKey: _formKeys[3], formData: _formData, onNext: _nextStep, onPrevious: _previousStep);
      default:
        return const SizedBox.shrink();
    }
  }
}
