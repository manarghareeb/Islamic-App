import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';

class GradientIconContainer extends StatelessWidget {
  const GradientIconContainer({
    super.key,
    this.gradientColor,
    this.icon,
    this.width,
    this.height,
    this.text,
    this.isText = false,
    this.isBorder = false,
    this.radius,
    this.shadowColor,
    this.iconSize,
    this.iconColor,
    this.textStyle,
  });

  final List<Color>? gradientColor;
  final IconData? icon;
  final double? width;
  final double? height;
  final String? text;
  final bool isText;
  final bool isBorder;
  final double? radius;
  final Color? shadowColor;
  final double? iconSize;
  final Color? iconColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 56.w,
      height: height ?? 56.h,
      decoration: BoxDecoration(
        shape: isBorder ? BoxShape.rectangle : BoxShape.circle,
        borderRadius: isBorder ? BorderRadius.circular(radius ?? 25.r) : null,
        gradient: LinearGradient(
          colors:
              gradientColor ??
              [
                AppColors.primaryColor,
                AppColors.primaryColor,
                AppColors.darkPrimaryColor,
              ],
          tileMode: TileMode.mirror,
        ),
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? Colors.black.withOpacity(0.10),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: isText
          ? Center(
              child: Text(text ?? '', style: textStyle ?? AppStyles.font16RegularWhiteColor),
            )
          : Icon(icon, color: iconColor ?? Colors.white, size: iconSize ?? 24.sp),
    );
  }
}
