import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/styles.dart';

class PrayerTimes extends StatelessWidget {
  const PrayerTimes({super.key, this.timings});
  final Map<String, String>? timings;

  @override
  Widget build(BuildContext context) {
    if (timings == null || timings!.isEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(6, (index) {
          return Column(
            children: [
              Icon(Icons.access_time, size: 18.sp, color: Colors.grey),
              SizedBox(height: 5.h),
              Text('--', style: AppStyles.font12RegularGreyColor),
              Text('--:--', style: AppStyles.font12RegularGreyColor),
            ],
          );
        }),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: timings!.entries.map((entry) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              getIcon(entry.key),
              size: 18.sp,
              color: const Color(0xFFC09C3E),
            ),
            SizedBox(height: 5.h),
            Text(entry.key, style: AppStyles.font12RegularGreyColor),
            Text(
              entry.value,
              style: AppStyles.font24MediumBlackColor.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  IconData getIcon(String name) {
    switch (name) {
      case "الفجر":
        return Icons.wb_twilight;
      case "الشروق":
        return Icons.wb_sunny;
      case "الظهر":
        return Icons.wb_sunny_rounded;
      case "العصر":
        return Icons.wb_cloudy;
      case "المغرب":
        return Icons.wb_twilight;
      case "العشاء":
        return Icons.nightlight_round;
      default:
        return Icons.access_time;
    }
  }
}
