import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

class MemberNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const MemberNavBar({super.key,required this.currentIndex,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      //notchMargin: 6,
      elevation: 0,
      shape: CircularNotchedRectangle(),
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: BottomNavigationBar(
          currentIndex:  currentIndex,
          onTap: onTap,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.primaryNavy,
          unselectedItemColor: AppColors.iconSecondary,
          selectedLabelStyle: AppTextStyles.labelSmall,
          unselectedLabelStyle: AppTextStyles.labelSmall,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/icon_home.svg'),
              activeIcon: SvgPicture.asset('assets/icons/home_active_icon.svg'),
              label: 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/complaint_icon.svg'),
              activeIcon: SvgPicture.asset('assets/icons/complaint_active.svg'),
              label: 'تقديم شكوى',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/inquiry_member_icon.svg'),
              activeIcon: SvgPicture.asset('assets/icons/inquiry_active_member_icon.svg'),
              label: 'استفسارات',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/setting_icon.svg'),
              activeIcon: SvgPicture.asset('assets/icons/setting_active_icon.svg'),
              label: 'الإعدادات',
            ),
          ]),
    );
  }
}
