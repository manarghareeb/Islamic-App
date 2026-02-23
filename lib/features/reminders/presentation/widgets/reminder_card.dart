import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/core/widgets/gradient_icon_container.dart';

class ReminderCard extends StatelessWidget {
  const ReminderCard({
    super.key,
    required this.title,
    required this.time,
    required this.isActive,
    required this.icon,
    required this.gradientColor,
    this.onToggle,
  });
  final String title;
  final String time;
  final bool isActive;
  final IconData icon;
  final List<Color> gradientColor;
  final void Function(bool)? onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.12),
          width: 1.w,
        ),
      ),
      child: Row(
        children: [
          GradientIconContainer(
            icon: icon,
            radius: 24.r,
            isBorder: true,
            gradientColor: gradientColor,
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppStyles.font18MediumBlackColor),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 14.sp,
                    color: AppColors.greyColor,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    time,
                    style: AppStyles.font14RegularWhiteColor.copyWith(
                      color: AppColors.greyColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Switch(
            value: isActive,
            onChanged: onToggle,
            activeThumbColor: AppColors.primaryColor,
            inactiveThumbColor: Colors.black.withOpacity(0.3),
            activeTrackColor: AppColors.primaryColor.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
