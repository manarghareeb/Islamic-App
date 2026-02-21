import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:islamic_app/core/routing/app_router.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/core/widgets/custom_button_widget.dart';
import 'package:islamic_app/core/widgets/gradient_icon_container.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String selectedLang = 'ar';

  final List<Map<String, String>> languages = [
    {'name': 'العربية', 'sub': 'Arabic', 'code': 'ar', 'flag': '🇸🇦'},
    {'name': 'English', 'sub': 'English', 'code': 'en', 'flag': '🇺🇸'},
    {'name': 'اردو', 'sub': 'Urdu', 'code': 'ur', 'flag': '🇵🇰'},
    {'name': 'Français', 'sub': 'French', 'code': 'fr', 'flag': '🇫🇷'},
  ];

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
            /*Positioned(
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
            ),*/
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
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  SizedBox(height: 50.h),
                  Center(
                    child: GradientIconContainer(
                      icon: Icons.language,
                      width: 96.w,
                      height: 96.h,
                      isBorder: true,
                      radius: 32.r,
                      iconSize: 40.sp,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text('اختر اللغة', style: AppStyles.font36MediumBlackColor),
                  SizedBox(height: 8.h),
                  Text(
                    'Select Your Preferred Language',
                    style: AppStyles.font16RegularGreyColor,
                  ),
                  SizedBox(height: 40.h),
                  Expanded(
                    child: ListView.separated(
                      itemCount: languages.length,
                      separatorBuilder: (_, __) => SizedBox(height: 16.h),
                      itemBuilder: (context, index) {
                        bool isSelected = selectedLang == languages[index]['code'];
                        return GestureDetector(
                          onTap: () => setState(
                            () => selectedLang = languages[index]['code']!,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primaryColor
                                    : Colors.transparent,
                              ),
                              color: isSelected
                                  ? AppColors.primaryColor.withOpacity(0.05)
                                  : Colors.white,
                            ),
                            child: Row(
                              children: [
                                if (isSelected)
                                  GradientIconContainer(
                                    icon: Icons.check,
                                    width: 32.w,
                                    height: 32.h,
                                  ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      languages[index]['name']!,
                                      style: AppStyles.font24MediumBlackColor
                                          .copyWith(fontSize: 20.sp),
                                    ),
                                    Text(
                                      languages[index]['sub']!,
                                      style: AppStyles.font14RegularWhiteColor
                                          .copyWith(color: AppColors.greyColor),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  languages[index]['flag']!,
                                  style: TextStyle(fontSize: 24.sp),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 40.h),
                  CustomButtonWidget(
                    title: 'متابعة',
                    onPressed: () =>
                        GoRouter.of(context).go(AppRouter.locationPermissionScreen),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
