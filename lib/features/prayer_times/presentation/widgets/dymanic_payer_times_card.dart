import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/core/widgets/gradient_icon_container.dart';
import 'package:islamic_app/features/prayer_times/presentation/cubit/prayer_cubit.dart';
import 'package:islamic_app/features/prayer_times/presentation/views/payer_times_screen.dart';

class DymanicPayerTimesCard extends StatelessWidget {
  const DymanicPayerTimesCard({super.key, required this.prayer});
  final Prayer prayer;

  @override
  Widget build(BuildContext context) {
    bool isPast = prayer.status == PrayerStatus.past;
    bool isCurrent = prayer.status == PrayerStatus.current;
    return Opacity(
      opacity: isPast ? 0.5 : 1.0,
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isCurrent ? AppColors.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: isCurrent
              ? Border.all(color: AppColors.yellowColor, width: 2.w)
              : Border.all(color: Colors.transparent),
          gradient: LinearGradient(
            colors: isCurrent
                ? [
                    AppColors.primaryColor,
                    AppColors.primaryColor,
                    AppColors.darkPrimaryColor,
                  ]
                : [Colors.white, Colors.white],
          ),
          boxShadow: isCurrent
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 50,
                    offset: Offset(0, 25),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.transparent,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                GradientIconContainer(
                  gradientColor: isCurrent
                      ? [
                          Colors.white.withOpacity(0.2),
                          Colors.white.withOpacity(0.2),
                        ]
                      : [
                          AppColors.primaryColor.withOpacity(0.1),
                          AppColors.yellowColor.withOpacity(0.1),
                        ],
                  icon: prayer.icon,
                  iconColor: AppColors.yellowColor,
                ),
                SizedBox(width: 16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      prayer.name,
                      style: AppStyles.font24MediumBlackColor.copyWith(
                        fontSize: 20.sp,
                        color: isCurrent ? Colors.white : AppColors.blackColor,
                      ),
                    ),
                    if (isCurrent)
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 3.r,
                            backgroundColor: Colors.white70,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'بعد ساعة و 15 دقيقة',
                            style: AppStyles.font14RegularWhiteColor,
                          ),
                        ],
                      ),
                    if (isCurrent == false && isPast == false)
                      Text('قادمة', style: AppStyles.font12RegularGreyColor),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Text(
                      prayer.time,
                      style: AppStyles.font30MediumWhiteColor.copyWith(
                        color: isCurrent ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'مفعّل',
                          style: AppStyles.font12RegularGreyColor.copyWith(
                            color: isCurrent
                                ? Colors.white.withOpacity(0.8)
                                : AppColors.greyColor,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Transform.scale(
                          scale: 0.8,
                          child: Switch(
                            value: context.watch<PrayerCubit>().prayerNotificationsStatus[prayer.name] ?? true,
                            onChanged: (val) {
                              context.read<PrayerCubit>().togglePrayerNotification(prayer.name, val);
                            },
                            activeThumbColor: Colors.white,
                            activeTrackColor: isCurrent
                                ? Colors.white.withOpacity(0.5)
                                : AppColors.primaryColor,
                            inactiveTrackColor: Colors.grey[300],
                            thumbColor: const WidgetStatePropertyAll(
                              Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Icon(
                          Icons.notifications_none_outlined,
                          color: isCurrent
                              ? Colors.white
                              : AppColors.primaryColor,
                          size: 24.sp,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            if (isCurrent) ...[
              Divider(color: Colors.white.withOpacity(0.2)),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "الوقت المتبقي",
                    style: AppStyles.font14RegularWhiteColor,
                  ),
                  Text("45%", style: AppStyles.font14RegularWhiteColor),
                ],
              ),
              SizedBox(height: 10.h),
              LinearProgressIndicator(
                value: 0.45,
                backgroundColor: Colors.white.withOpacity(0.2),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                minHeight: 6,
                borderRadius: BorderRadius.circular(10),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
