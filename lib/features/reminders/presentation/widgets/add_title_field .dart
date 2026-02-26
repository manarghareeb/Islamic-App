import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';

class AddTitleField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hintText;
  const AddTitleField({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppStyles.font14MediumBlackColor),
        SizedBox(height: 8.h),
        Container(
          height: 40.h,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
          child: TextField(
            style: AppStyles.font14RegularWhiteColor.copyWith(
              color: AppColors.greyColor,
            ),
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppStyles.font14RegularWhiteColor.copyWith(
                color: AppColors.greyColor,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
