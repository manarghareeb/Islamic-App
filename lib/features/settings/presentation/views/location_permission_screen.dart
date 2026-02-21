import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:islamic_app/core/routing/app_router.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/core/widgets/custom_button_widget.dart';
import 'package:islamic_app/core/widgets/gradient_icon_container.dart';
import 'package:islamic_app/features/settings/presentation/widgets/permission_info_card.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
            left: MediaQuery.of(context).size.width * 0.7,
            bottom: MediaQuery.of(context).size.height * 0.8,
            child: Container(
              width: 256.w,
              height: 256.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 3,
                  color: AppColors.greyColor.withOpacity(0.04),
                ),
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.05,
            bottom: MediaQuery.of(context).size.height * 0.07,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.9,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 3,
                  color: AppColors.greyColor.withOpacity(0.04),
                ),
              ),
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width * 0.75,
            bottom: -50,
            child: Container(
              width: 192.w,
              height: 192.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 3,
                  color: AppColors.yellowColor.withOpacity(0.1),
                ),
              ),
            ),
          ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Column(
                children: [
                  Center(
                    child: GradientIconContainer(
                      icon: Icons.location_on,
                      width: 96.w,
                      height: 96.h,
                      isBorder: true,
                      radius: 32.r,
                      iconSize: 40.sp,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text('تحديد الموقع', style: AppStyles.font36MediumBlackColor),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      'نحتاج إلى موقعك لحساب أوقات الصلاة الدقيقة في منطقتك وإظهار المساجد القريبة منك',
                      textAlign: TextAlign.center,
                      style: AppStyles.font16RegularGreyColor,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  PermissionInfoCard(
                    title: 'أوقات الصلاة الدقيقة',
                    subTitle: 'حساب دقيق بناءً على موقعك',
                    icon: Icons.my_location,
                  ),
                  SizedBox(height: 16.h),
                  PermissionInfoCard(
                    title: 'المساجد القريبة',
                    subTitle: 'اكتشف المساجد من حولك',
                    icon: Icons.near_me,
                  ),
                  SizedBox(height: 16.h),
                  PermissionInfoCard(
                    title: 'خصوصية محمية',
                    subTitle: 'بياناتك آمنة ومحمية',
                    icon: Icons.shield_outlined,
                  ),
                  const Spacer(),
                  CustomButtonWidget(
                    title: 'السماح بالوصول للموقع',
                    onPressed: () async {},
                  ),
                  TextButton(
                    onPressed: () => context.go(AppRouter.homeScreen),
                    child: Text(
                      'تخطي الآن',
                      style: AppStyles.font16RegularGreyColor,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'يمكنك تغيير هذا الإعداد لاحقًا من الإعدادات', 
                        style: AppStyles.font12RegularGreyColor,
                      ),
                      SizedBox(width: 8.w,),
                      Icon(Icons.shield_outlined , size: 12.sp,),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
