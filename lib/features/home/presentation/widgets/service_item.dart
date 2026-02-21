import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/core/widgets/gradient_icon_container.dart';

class ServiceItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onTap;

  const ServiceItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientIconContainer(
                gradientColor: isPrimary
                    ? [
                        AppColors.primaryColor,
                        AppColors.primaryColor,
                        AppColors.darkPrimaryColor,
                      ]
                    : [AppColors.yellowColor, AppColors.darkYellowColor],
                icon: icon,
              ),
              SizedBox(height: 10.h),
              Text(title, style: AppStyles.font18MediumBlackColor),
              Text(subtitle, style: AppStyles.font12RegularGreyColor),
            ],
          ),
        ),
      ),
    );
  }
}
