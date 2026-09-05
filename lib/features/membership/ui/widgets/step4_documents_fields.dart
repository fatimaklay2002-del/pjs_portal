import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/Constants/app_strings.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';
import 'attachment_item.dart';
import 'attachment_spec.dart';
import 'step_wrapper.dart';

class Step4DocumentsFields extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, PlatformFile?> files;
  final bool isLoading;
  final VoidCallback onPreviousArrow;
  final ValueChanged<String> onPick;
  final VoidCallback onSubmit;

  const Step4DocumentsFields({
    super.key,
    required this.formKey,
    required this.files,
    required this.isLoading,
    required this.onPreviousArrow,
    required this.onPick,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return StepWrapper(
      onBackAction: onPreviousArrow,
      onNextArrow: null,
      onPreviousArrow: onPreviousArrow,
      showArrows: false,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset('assets/icons/documents_icon.svg', height: 18.h, width: 18.h),
                SizedBox(width: 16.w),
                Text(AppStrings.documents, style: AppTextStyles.headlineSmall),
              ],
            ),
            SizedBox(height: 20.h),
            for (final spec in attachmentSpecs)
              AttachmentItem(
                label: spec.label,
                file: files[spec.key],
                isRequired: spec.required,
                onTap: () => onPick(spec.key),
              ),
            SizedBox(height: 30.h),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : PrimaryButton(
                    text: AppStrings.submit,
                    width: double.infinity,
                    backgroundColor: AppColors.primaryNavy,
                    onPressed: onSubmit,
                  ),
          ],
        ),
      ),
    );
  }
}
