import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';

class CustomDividerWithShadow extends StatelessWidget {
  const CustomDividerWithShadow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Container(
        width: 80.w,
        height: 1.h,
        decoration: BoxDecoration(
          color: AppColors.yellowColor,
          border: Border.symmetric(
            horizontal: BorderSide(color: Colors.black.withOpacity(0.1)),
          ),
        ),
      ),
    );
  }
}
