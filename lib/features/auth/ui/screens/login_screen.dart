import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Constants/app_strings.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../logic/auth_cubit.dart';
import '../../logic/auth_state.dart';
import '../widgets/login_header.dart';
import '../widgets/login_form_fields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          switch (state) {
            case AuthAuthenticated(:final user):
              if (user.role == AppConstants.roleAdmin) {
                context.go(AppConstants.routeAdminDashboard);
              } else {
                context.go(AppConstants.routeUserHome);
              }
            case AuthError(:final message):
              context.showErrorSnackBar(message);
            default:
              break;
          }
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.all(32.w),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const LoginHeader(),
                      SizedBox(height: 32.h),
                      LoginFormFields(
                        emailController: _emailController,
                        passwordController: _passwordController,
                      ),
                      SizedBox(height: 32.h),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) => PrimaryButton(
                          width: double.infinity,
                          text: AppStrings.login,
                          onPressed: _handleLogin,
                          isLoading: state is AuthLoading,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}