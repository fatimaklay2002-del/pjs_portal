import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

class AdminNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const AdminNavBar({super.key,required this.currentIndex,required this.onTap});

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
          icon: SvgPicture.asset('assets/icons/membership_icon.svg'),
          activeIcon: SvgPicture.asset('assets/icons/membership_active.svg'),
          label: 'طلبات عضوية',
        ),
         BottomNavigationBarItem(
          icon: SizedBox(width: 40),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/inquiries.svg'),
          activeIcon: SvgPicture.asset('assets/icons/inquiries_active.svg'),
          label: 'الواردات',
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

class AdminAddNewsButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AdminAddNewsButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  FloatingActionButton(
        onPressed: onPressed,
         elevation: 4,
      highlightElevation: 8,
        shape: CircleBorder(
          side: BorderSide(color: AppColors.white, width: 4.w),
        ),
        backgroundColor: AppColors.primaryNavy,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
    );
  }
}
