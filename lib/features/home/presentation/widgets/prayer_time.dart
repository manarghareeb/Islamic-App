import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/styles.dart';

class PrayerTimes extends StatelessWidget {
  const PrayerTimes({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> prayerList = [
      {'name': 'الفجر', 'time': '5:15', 'icon': Icons.wb_twilight},
      {'name': 'الشروق', 'time': '6:45', 'icon': Icons.wb_sunny},
      {'name': 'الظهر', 'time': '12:30', 'icon': Icons.wb_sunny_rounded},
      {'name': 'العصر', 'time': '3:45', 'icon': Icons.wb_cloudy},
      {'name': 'المغرب', 'time': '6:15', 'icon': Icons.wb_twilight},
      {'name': 'العشاء', 'time': '7:45', 'icon': Icons.nightlight_round},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: prayerList.map((item) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              item['icon'], 
              size: 18.sp, 
              color: const Color(0xFFC09C3E),
            ),
            SizedBox(height: 5.h),
            Text(
              item['name'], 
              style: AppStyles.font12RegularGreyColor,
            ),
            Text(
              item['time'],
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
}