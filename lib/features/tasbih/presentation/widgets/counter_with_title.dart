import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/core/widgets/gradient_icon_container.dart';

class CounterWithTitle extends StatelessWidget {
  const CounterWithTitle({super.key, required this.title, required this.count});
  final String title;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GradientIconContainer(
          //width: 48.w,
          //height: 48.h,
          isText: true,
          text: count,
          textStyle: AppStyles.font24MediumBlackColor,
          gradientColor: [
            AppColors.primaryColor.withOpacity(0.1),
            AppColors.yellowColor.withOpacity(0.1),
          ],
        ),
        SizedBox(height: 8.h),
        Text(title, style: AppStyles.font12RegularGreyColor),
      ],
    );
  }
}
