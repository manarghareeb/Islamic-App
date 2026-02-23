import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';

class ReminderTimePicker extends StatelessWidget {
  final TimeOfDay? selectedTime;
  final Function(TimeOfDay) onTimePicked;

  const ReminderTimePicker({
    super.key,
    required this.selectedTime,
    required this.onTimePicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("وقت التذكير", style: AppStyles.font14MediumBlackColor),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () async {
            final pickedTime = await showTimePicker(
              builder: (context, child) {
                return Theme(
                  data: ThemeData(
                    colorScheme: ColorScheme.light(
                      primary: AppColors.primaryColor,
                      onPrimary: Colors.white,
                      surface: Colors.white,
                      onSurface: AppColors.blackColor,
                    ),
                    dialogTheme: DialogThemeData(
                      backgroundColor: AppColors.whiteBackgroundColor,
                    ),
                  ),
                  child: child!,
                );
              },
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (pickedTime != null) onTimePicked(pickedTime);
          },
          child: Container(
            width: double.infinity,
            height: 40.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Text(
              selectedTime == null
                  ? "اختر الوقت"
                  : selectedTime!.format(context),
              style: AppStyles.font14MediumBlackColor.copyWith(
                color: selectedTime == null
                    ? AppColors.greyColor
                    : AppColors.blackColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}