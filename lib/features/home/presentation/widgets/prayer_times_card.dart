import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/core/widgets/gradient_icon_container.dart';
import 'package:islamic_app/features/home/presentation/widgets/linear_progress_indicator_widget.dart';
import 'package:islamic_app/features/home/presentation/widgets/prayer_time.dart';

class PrayerTimesCard extends StatelessWidget {
  const PrayerTimesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 50,
            spreadRadius: -12,
            offset: const Offset(0, 25),
          ),
        ],
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Row(
              children: [
                GradientIconContainer(
                  width: 48.w,
                  height: 48.h,
                  icon: Icons.access_time_rounded
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الصلاة القادمة',
                      style: AppStyles.font12RegularGreyColor,
                    ),
                    Text('صلاة الظهر', style: AppStyles.font24MediumBlackColor),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '12:30',
                      style: AppStyles.font30MediumWhiteColor.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 2,
                          backgroundColor: AppColors.primaryColor,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'بعد ساعة و 15 دقيقة',
                          style: AppStyles.font12RegularGreyColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 42.h),
            const LinearProgressIndicatorWidget(),
            SizedBox(height: 40.h),
            Divider(color: AppColors.primaryColor.withOpacity(0.12)),
            SizedBox(height: 12.h),
            const PrayerTimes(),
          ],
        ),
      ),
    );
  }
}

