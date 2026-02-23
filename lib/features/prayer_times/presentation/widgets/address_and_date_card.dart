import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/styles.dart';

class AddressAndDateCard extends StatelessWidget {
  const AddressAndDateCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Colors.white,
                size: 15.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'الرياض، المملكة العربية السعودية',
                style: AppStyles.font14RegularWhiteColor,
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Column(
            children: [
              Text(
                "الثلاثاء",
                style: AppStyles.font14RegularWhiteColor,
              ),
              SizedBox(height: 8.h),
              Text(
                "21 أكتوبر 2025",
                style: AppStyles.font30MediumWhiteColor.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                width: 80.w,
                height: 1.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Colors.transparent,
                      Colors.white.withOpacity(0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "28 ربيع الثاني 1447",
                style: AppStyles.font16RegularWhiteColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}