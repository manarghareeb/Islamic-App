import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';

class AddReminderTitleField extends StatelessWidget {
  final TextEditingController controller;
  const AddReminderTitleField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("عنوان التذكير", style: AppStyles.font14MediumBlackColor),
        SizedBox(height: 8.h),
        Container(
          height: 40.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: TextField(
            style: AppStyles.font14RegularWhiteColor.copyWith(
              color: AppColors.greyColor,
            ),
            controller: controller,
            decoration: InputDecoration(
              hintText: "مثال: صلاة الضحى، قراءة ورد...",
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