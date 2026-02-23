import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({
    super.key,
    required this.mediaHeight,
    required this.title,
    required this.subTitle,
    required this.widget,
    this.isHome = false,
    this.isAthkar = false,
  });
  final double mediaHeight;
  final String title;
  final String subTitle;
  final Widget widget;
  final bool isHome;
  final bool isAthkar;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * mediaHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            AppColors.primaryColor,
            AppColors.primaryColor,
            AppColors.darkPrimaryColor,
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(48.r),
          bottomRight: Radius.circular(48.r),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -80,
            top: -60,
            child: Container(
              width: 196.w,
              height: 196.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 5,
                  color: AppColors.primaryColor.withOpacity(0.5),
                ),
              ),
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width * 0.85,
            top: MediaQuery.of(context).size.height * 0.07,
            child: Container(
              width: 160.w,
              height: 160.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 3,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50.h, left: 20.w, right: 20.w),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isAthkar == true || isHome == false)
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                    SizedBox(width: 16.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppStyles.font24MediumBlackColor.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          subTitle,
                          style: AppStyles.font14RegularWhiteColor,
                        ),
                      ],
                    ),
                    const Spacer(),
                    if (isAthkar == true)
                      CircleAvatar(
                        backgroundColor: Colors.white24,
                        child: Text("🙌"),
                      )
                    else ...[
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.settings_outlined,
                              color: Colors.white,
                              size: 24.sp,
                            ),
                          ),
                          if (isHome == true) SizedBox(width: 15.w),
                          if (isHome == true)
                            Icon(
                              Icons.dark_mode_outlined,
                              color: Colors.white,
                              size: 24.sp,
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 24.h),
                widget,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
