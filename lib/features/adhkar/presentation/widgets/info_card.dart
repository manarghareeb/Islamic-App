import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/styles.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: AppStyles.font20RegularYellowColor.copyWith(
              color: Colors.white
            ),
          ),
          SizedBox(height: 5.h,),
          Text(
            title,
            style: AppStyles.font14RegularWhiteColor,
          ),
        ],
      ),
    );
  }
}
