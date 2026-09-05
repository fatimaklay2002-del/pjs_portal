import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pjs_portal/core/Constants/app_strings.dart';
import 'package:pjs_portal/features/settings/settings_sub_screens/widgets/settings_item.dart';
import 'package:pjs_portal/features/settings/settings_sub_screens/widgets/user_info_card.dart';

import '../../core/Constants/app_constants.dart';
import '../../core/dialogs/logout_dialog.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/theme/app_color.dart';
import '../../core/theme/app_text_styles.dart';
import '../members/ui/screens/member_update_data_screen.dart';
import 'logic/settings_cubit.dart';
import 'logic/settings_state.dart';
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          AppStrings.settingsTitle,
          style: AppTextStyles.headlineMedium,
        ),
      ),
      body: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) async {
          if (state is GetMemberDataLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) =>
              const Center(child: CircularProgressIndicator()),
            );
          }

          if (state is GetMemberDataSuccess) {
            // أغلق مؤشر التحميل
            if (context.mounted && Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }

            // افتح شاشة التحديث وانتظر الرجوع
            if (context.mounted) {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) =>
                      MemberUpdateScreen(member: state.member),
                ),
              );
            }

            // بعد الرجوع: أعد تحميل الإعدادات لتحديث البيانات
            if (context.mounted) {
              context.read<SettingsCubit>().loadInitialSettings();
            }
          }

          if (state is SettingsError) {
            // أغلق مؤشر التحميل لو كان مفتوحاً
            if (context.mounted && Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
            if (context.mounted) {
              context.showErrorSnackBar(state.message);
            }
          }
        },

        buildWhen: (previous, current) =>
        current is SettingsLoading ||
            current is SettingsLoaded ||
            current is SettingsError,
        builder: (context, state) {
          if (state is SettingsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SettingsLoaded) {
            final member = state.member;
                member.role == AppConstants.roleJournalist;

            return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  // بطاقة المستخدم — للصحفي فقط
                 // if (isEmployee) ...[
                    UserInfoCard(
                      name: member.fullNameAr,
                      email: member.email,
                      membershipType: member.membershipType,

                    ),
                    SizedBox(height: 12.h),
                 // ],

                  // قائمة الإعدادات
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SettingsItem(
                          icon: Icons.sync_outlined,
                          label: AppStrings.updateData,
                          onTap: () => context
                              .read<SettingsCubit>()
                              .getMemberDataForUpdate(member.id),
                        ),
                        SettingsItem(
                          icon: Icons.article_outlined,
                          label: AppStrings.termsAndConditions,
                          onTap: () => context.push('/term'),
                        ),
                        SettingsItem(
                          icon: Icons.lock_outline,
                          label: AppStrings.privacyPolicy,
                          onTap: () => context.push('/privacy'),
                        ),
                        SettingsItem(
                          icon: Icons.code_outlined,
                          label: AppStrings.aboutDevelopers,
                          onTap: () => context.push('/about-developer'),
                        ),
                        SettingsItem(
                          icon: Icons.info_outline,
                          label: AppStrings.aboutApp,
                          onTap: () => context.push('/about-app'),
                        ),
                        SettingsItem(
                          icon: Icons.logout,
                          label: AppStrings.logout,
                          isRed: true,
                          showDivider: false,
                          onTap: () => LogoutDialog.show(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}