import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/core/widgets/gradient_icon_container.dart';

class PageViewBody extends StatelessWidget {
  const PageViewBody({super.key, required this.page});
  final Map<String, dynamic> page;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 0.8,
              colors: [
                (page['color'] as Color).withOpacity(0.05),
                Colors.transparent,
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              children: [
                GradientIconContainer(
                  gradientColor: page['gradientColor'],
                  width: 100.w,
                  height: 100.w,
                  icon: page['icon'],
                  radius: 20.r,
                  isBorder: true,
                  iconSize: 45.sp,
                  shadowColor: (page['color'] as Color).withOpacity(0.4),
                ),
                SizedBox(height: 60.h),
                Text(
                  page['title']!,
                  style: AppStyles.font36MediumBlackColor.copyWith(
                    fontSize: 28.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                Container(
                  width: 64.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.transparent,
                        Color(0xFF6B6B6B).withOpacity(0.3),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  page['subtitle']!,
                  style: AppStyles.font18RegularGreyColor.copyWith(height: 1.6),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
