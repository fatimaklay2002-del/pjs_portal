import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Constants/app_strings.dart';
import '../../../../core/widgets/custom_outlined_button.dart';
import '../../../../core/widgets/primary_button.dart';

class WelcomeActionsWidget extends StatelessWidget {
  const WelcomeActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryButton(
          width: double.infinity,
          icon: Icons.person_add_alt_1_outlined,
          text: AppStrings.newMembershipRequest,
          onPressed: () => context.push(AppConstants.routeMembershipRequest),
        ),
        const SizedBox(height: 12),
        CustomOutlinedButton(
          width: double.infinity,
          icon: Icons.login_outlined,
          text: 'تسجيل الدخول (عضو / مسؤول)',
          onPressed: () => context.push(AppConstants.routeEmployeeLogin),
        ),
      ],
    );
  }
}