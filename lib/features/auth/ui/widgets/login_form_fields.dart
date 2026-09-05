
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/Constants/app_strings.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/widgets/custom_text_field.dart';

class LoginFormFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginFormFields({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: AppStrings.username,
          hint: AppStrings.enterUsername,
          icon: Icon(Icons.person_outline, color: AppColors.lightGrey, size: 20.w),
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (v) {
            if (v == null || v.isEmpty) return AppStrings.fieldRequired;
            if (!v.contains('@')) return AppStrings.invalidEmail;
            return null;
          },
        ),
        SizedBox(height: 24.h),
        CustomTextField(
          label: AppStrings.password,
          hint: AppStrings.enterPassword,
          icon: Icon(Icons.lock_outline, color: AppColors.lightGrey, size: 20.w),
          obscureText: true,
          controller: passwordController,
          validator: (v) {
            if (v == null || v.isEmpty) return AppStrings.fieldRequired;
            if (v.length < 6) return AppStrings.passwordTooShort;
            return null;
          },
        ),
      ],
    );
  }
}