import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/logic/auth_cubit.dart';
import '../Constants/app_strings.dart';
import '../theme/app_color.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  // دالة ثابتة لتسهيل استدعاء الديالوج من أي مكان
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const LogoutDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        AppStrings.logoutConfirmTitle,
        textAlign: TextAlign.right,
      ),
      content: const Text(
        AppStrings.logoutConfirmMessage,
        textAlign: TextAlign.right,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(AppStrings.cancel),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accentRed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();

            context.read<AuthCubit>().logout();

            context.go('/welcome');
          },
          child: const Text(
            AppStrings.logoutConfirm,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}