import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/core/widgets/gradient_icon_container.dart';
import 'package:islamic_app/features/home/presentation/widgets/linear_progress_indicator_widget.dart';
import 'package:islamic_app/features/home/presentation/widgets/prayer_time.dart';
import 'package:islamic_app/features/prayer_times/domain/entities/prayer_time_entity.dart';

class PrayerTimesCard extends StatelessWidget {
  const PrayerTimesCard({super.key, required this.prayerData});
  final PrayerTimesEntity? prayerData;

  @override
  Widget build(BuildContext context) {
    final nextPrayer = getNextPrayer(prayerData?.timings);
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
        textDirection: ui.TextDirection.rtl,
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
                    Text(
                      prayerData == null ? 'جارِ التحميل...' : 'صلاة ${nextPrayer['name']}',
                      style: AppStyles.font24MediumBlackColor
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      nextPrayer['time'] ?? '--:--',
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
                          nextPrayer['remaining'] ?? '',
                          style: AppStyles.font12RegularGreyColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 42.h),
            LinearProgressIndicatorWidget(progressValue: nextPrayer['percent'] ?? 0.0),
            SizedBox(height: 40.h),
            Divider(color: AppColors.primaryColor.withOpacity(0.12)),
            SizedBox(height: 12.h),
            PrayerTimes(timings: prayerData?.timings ?? {}),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> getNextPrayer(Map<String, String>? timings) {
    if (timings == null) return {};

    final now = DateTime.now();
    final format = DateFormat("HH:mm");
    
    final prayerKeys = ["الفجر", "الشروق", "الظهر", "العصر", "المغرب", "العشاء"];
    
    List<MapEntry<String, DateTime>> prayerDateTimes = [];

    for (var key in prayerKeys) {
      if (timings.containsKey(key)) {
        String timeStr = timings[key]!.split(' ')[0]; 
        DateTime tempTime = format.parse(timeStr);
        DateTime fullDateTime = DateTime(now.year, now.month, now.day, tempTime.hour, tempTime.minute);
        prayerDateTimes.add(MapEntry(key, fullDateTime));
      }
    }

    MapEntry<String, DateTime>? next;
    MapEntry<String, DateTime>? current;

    for (int i = 0; i < prayerDateTimes.length; i++) {
      if (prayerDateTimes[i].value.isAfter(now)) {
        next = prayerDateTimes[i];
        current = i > 0 ? prayerDateTimes[i - 1] : prayerDateTimes.last;
        break;
      }
    }

    if (next == null) {
      next = prayerDateTimes.first;
      current = prayerDateTimes.last;
    }

    final diff = next.value.difference(now);
    final totalWindow = next.value.difference(current!.value).inMinutes.abs();
    final elapsed = now.difference(current.value).inMinutes.abs();
    
    double percent = totalWindow != 0 ? (elapsed / totalWindow).clamp(0.0, 1.0) : 0.0;

    String remainingText = "";
    if (diff.inHours > 0) {
      remainingText = "بعد ${diff.inHours} ساعة و ${diff.inMinutes % 60} دقيقة";
    } else {
      remainingText = "بعد ${diff.inMinutes} دقيقة";
    }

    return {
      "name": next.key,
      "time": timings[next.key],
      "remaining": remainingText,
      "percent": percent,
    };
  }
}

