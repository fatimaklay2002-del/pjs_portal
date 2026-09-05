import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_color.dart';
import '../widgets/welcome_actions_widget.dart';
import '../widgets/welcome_feature_grid.dart';
import '../widgets/welcome_header_widget.dart';
import '../widgets/welcome_logo_widget.dart';
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 24.h),
                        WelcomeLogoWidgets(),
                         SizedBox(height: 24.h),
                        const WelcomeHeaderWidget(),
                         SizedBox(height: 24.h),
                        const WelcomeFeatureGrid(),
                      ],
                    ),
                  ),
                ),
                const WelcomeActionsWidget(),
                 SizedBox(height: 50.h),

              ],
            ),
          ),
        ),
      ),
    );
  }
}