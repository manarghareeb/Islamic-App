import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:islamic_app/core/routing/app_router.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/features/adhkar/presentation/views/athkar_screen.dart';

class AthkarCard extends StatelessWidget {
  const AthkarCard({super.key, required this.category});
  final AthkarCategory category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: category.onTap,
      onTap: ()=> context.push(AppRouter.athkarDetailsScreen),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: category.color,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: category.color.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(category.icon, style: TextStyle(fontSize: 30.sp)),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name,
                      style: AppStyles.font18MediumBlackColor.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      category.count,
                      style: AppStyles.font14RegularWhiteColor,
                    ),
                  ],
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16.sp),
              ],
            ),
          ],
        ),
      ),
    );
  }
}