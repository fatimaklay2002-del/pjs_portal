import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_color.dart';

import '../theme/app_text_styles.dart';

class CustomTextField extends StatefulWidget {
  final String? label;
  final String hint;
  final double? width;
  final Widget? icon;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int maxLines;

  const CustomTextField({
    super.key,
    this.label,
    this.width,
    required this.hint,
    this.icon,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.keyboardType,
    this.maxLines=1
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool isPassword;

  @override
  void initState() {
    super.initState();
    isPassword = widget.obscureText;
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          if (widget.label != null && widget.label!.isNotEmpty )...[ Text(
            widget.label!,
            style: AppTextStyles.labelLarge,
            textAlign: TextAlign.right,
          ),],
           SizedBox(height: 8.h),

          // Text Field
          TextFormField(
            controller: widget.controller,
            obscureText: isPassword,
            keyboardType: widget.keyboardType,
            validator: widget.validator,
            textAlign: TextAlign.right,
            maxLines: widget.maxLines,
            textDirection: TextDirection.rtl,
            style: AppTextStyles.bodyMedium,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: AppTextStyles.hint,
              filled: true,
              fillColor: AppColors.inputFill,
              prefixIcon: widget.icon != null
                  ? Padding(
                padding: EdgeInsets.all(12.w),
                child: widget.icon,
              )
                  : null,
              suffixIcon: widget.obscureText
                  ? IconButton(
                icon: SvgPicture.asset("assets/icons/eye.svg",
                  colorFilter: ColorFilter.mode(
                  isPassword
                  ? AppColors.iconSecondary // رمادي
                  : AppColors.primaryNavy,  // أخضر
                  BlendMode.srcIn,
                ),),
                onPressed: () {
                  setState(() {
                    isPassword = !isPassword;
                  });
                },
              )
                  : null,
              contentPadding:  EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:  BorderSide(
                  color: AppColors.inputBorder,
                  width: 1.w,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:  BorderSide(
                  color: AppColors.inputBorder,
                  width: 1.w,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:  BorderSide(
                  color: AppColors.primaryNavy,
                  width: 2.w,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:  BorderSide(
                  color: AppColors.accentRed,
                  width: 1.w,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:  BorderSide(
                  color: AppColors.accentRed,
                  width: 2.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
