import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_color.dart';
import '../theme/app_text_styles.dart';

class FilterRow extends StatelessWidget {
  final List<(String, String)> filters;
  final String selected;
  final Map<String, int> counts;
  final ValueChanged<String> onSelected;

  const FilterRow({super.key, 
    required this.filters,
    required this.selected,
    required this.counts,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: filters.reversed.map((f) {
          final key = f.$1;
          final label = f.$2;
          final count = counts[key] ?? 0;
          final isSelected = selected == key;

          return Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: GestureDetector(
              onTap: () => onSelected(key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 8.h,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryNavy
                      : AppColors.background,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected && count > 0) ...[
                      Text(
                        '$count',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 4.w),
                    ],
                    Text(
                      label,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: isSelected
                            ? AppColors.white
                            : AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
