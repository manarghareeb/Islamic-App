import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';

class AdviceCard extends StatelessWidget {
  const AdviceCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.yellowColor),
        gradient: LinearGradient(
          colors: [Color(0xFFF4E5C2), Color(0xFFE8D7B0)],
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.yellowColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.lightbulb_outline,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "نصيحة",
                  style: AppStyles.font18MediumBlackColor,
                ),
                SizedBox(height: 8.h),
                Text(
                  "المداومة على الأذكار اليومية تجلب السكينة والطمأنينة للقلب، احرص على تفعيل التذكيرات لتبقى على اتصال دائم بالله.",
                  style: AppStyles.font14RegularWhiteColor.copyWith(
                    color: AppColors.greyColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
