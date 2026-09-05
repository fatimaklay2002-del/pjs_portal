
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pjs_portal/core/extensions/context_extensions.dart';
import 'package:pjs_portal/features/membership/ui/widgets/step4_file_picker.dart';

import '../../logic/membership_cubit.dart';
import '../../logic/membership_form_data.dart';
import '../../logic/membership_state.dart';
import '../widgets/attachment_spec.dart';
import '../widgets/success_dialog.dart';
import '../widgets/step4_documents_fields.dart';

class Step4Documents extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final MembershipFormData formData;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const Step4Documents({
    super.key,
    required this.formKey,
    required this.formData,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  State<Step4Documents> createState() => _Step4DocumentsState();
}

class _Step4DocumentsState extends State<Step4Documents> {
  final Map<String, PlatformFile?> _files = {
    for (final s in attachmentSpecs) s.key: null,
  };
  final _picker = Step4FilePicker();

  Future<void> _pickFile(String key) async {
    try {
      final file = await _picker.pick();
      if (file == null) {
        if (mounted) context.showErrorSnackBar('تعذّر قراءة الملف، يرجى المحاولة مجدداً');
        return;
      }
      if (!mounted) return;
      setState(() => _files[key] = file);
    } catch (e) {
      if (!mounted) return;
      context.showErrorSnackBar('فشل في اختيار الملف: $e');
    }
  }

  void _submit() {
    if (!widget.formKey.currentState!.validate()) return;
    final missingRequired =
        attachmentSpecs.where((s) => s.required && _files[s.key] == null).isNotEmpty;
    if (missingRequired) {
      context.showErrorSnackBar('يرجى رفع الملفات الإلزامية (الصورة الشخصية، الهوية، الشهادة)');
      return;
    }
    context.read<MembershipCubit>().submitMembershipRequest(
      formData: widget.formData,
      files: _files,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MembershipCubit, MembershipState>(
      listener: (context, state) {
        if (state is MembershipError) context.showErrorSnackBar(state.message);
        if (state is MembershipSuccess) SuccessDialog.show(context);
      },
      builder: (context, state) => Step4DocumentsFields(
        formKey: widget.formKey,
        files: _files,
        isLoading: state is MembershipLoading,
        onPreviousArrow: widget.onPrevious,
        onPick: _pickFile,
        onSubmit: _submit,
      ),
    );
  }
}
