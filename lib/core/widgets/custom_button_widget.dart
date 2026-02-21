import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.title,
    required this.onPressed,
    this.width,
    this.backgroundColor,
    this.bordercolor,
    this.textColor,
    this.icon,
    this.textStyle,
    this.height,
  });

  final String title;
  final VoidCallback onPressed;
  final double? width;
  final Color? backgroundColor;
  final Color? bordercolor;
  final Color? textColor;
  final IconData? icon;
  final TextStyle? textStyle;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primaryColor,
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: bordercolor ?? AppColors.primaryColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
        gradient: LinearGradient(
          colors: <Color>[
            AppColors.primaryColor,
            AppColors.primaryColor,
            AppColors.darkPrimaryColor,
          ],
          tileMode: TileMode.mirror,
        ),
      ),
      width: width ?? double.infinity,
      height: height ?? 56.h,
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(icon, color: textColor ?? Colors.white, size: 20.sp),
            SizedBox(width: (icon != null) ? 10 : 0),
            Text(title, style: textStyle ?? AppStyles.font16RegularWhiteColor),
          ],
        ),
      ),
    );
  }
}
