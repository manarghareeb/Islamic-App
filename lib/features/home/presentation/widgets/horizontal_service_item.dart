import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/core/widgets/gradient_icon_container.dart';

class HorizontalServiceItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color>? color;

  const HorizontalServiceItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            GradientIconContainer(gradientColor: color, icon: icon),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(title, style: AppStyles.font18MediumBlackColor),
                Text(subtitle, style: AppStyles.font12RegularGreyColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
