import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/images.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/core/widgets/custom_divider_with_shadow.dart';
import 'package:islamic_app/features/onboarding/presentation/widgets/splash_dots_indicator.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  AppColors.primaryColor,
                  AppColors.primaryColor,
                  AppColors.darkPrimaryColor,
                ],
                tileMode: TileMode.mirror,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.w),
                  child: Image.asset(AppImages.test),
                ),
                Text('المصحف الشريف', style: AppStyles.font36MediumWhiteColor),
                const CustomDividerWithShadow(),
                Text(
                  '﴾ وَرَتِّلِ الْقُرْآنَ تَرْتِيلًا ﴿',
                  style: AppStyles.font20RegularYellowColor,
                ),
                SizedBox(height: 8.h),
                Text(
                  'سورة المزمل - آية 4',
                  style: AppStyles.font14RegularWhiteColor.copyWith(
                    color: Colors.white60,
                  ),
                ),
                SizedBox(height: 48.h),
                const SplashDotsIndicator(),
              ],
            ),
          ),
          Positioned(
            child: Padding(
              padding: EdgeInsets.only(left: 40.w, top: 80.h),
              child: Container(
                width: 128.w,
                height: 128.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.yellowColor.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width * 0.2,
            bottom: MediaQuery.of(context).size.height * 0.27,
            child: Container(
              width: 256.w,
              height: 256.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.yellowColor.withOpacity(0.5),
                ),
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.6,
            bottom: MediaQuery.of(context).size.height * 0.05,
            child: Container(
              width: 160.w,
              height: 160.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.yellowColor.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
