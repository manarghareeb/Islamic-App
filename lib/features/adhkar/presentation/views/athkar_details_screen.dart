import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/core/widgets/custom_header.dart';
import 'package:islamic_app/features/adhkar/domain/entities/adhkar_category_entity.dart';
import 'package:islamic_app/features/adhkar/presentation/widgets/info_card.dart';

class AthkarDetailsScreen extends StatelessWidget {
  const AthkarDetailsScreen({super.key, required this.category});
  final AdhkarCategoryEntity category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBackgroundColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            CustomHeader(
              mediaHeight: 0.3,
              title: category.categoryName,
              subTitle: "حصن المسلم اليومي",
              isHome: false,
              isAthkar: true,
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: InfoCard(
                      title: 'الفئات',
                      value: category.adhkarList.length.toString(),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: InfoCard(title: 'مكتملة اليوم', value: '0'),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: InfoCard(title: 'المفضلة', value: '0'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 27.w, right: 27.w, bottom: 32.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.arrow_back, size: 20.sp),
                        SizedBox(width: 16.w),
                        Text(
                          'العودة للفئات',
                          style: AppStyles.font18MediumBlackColor,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => Padding(
                          padding: EdgeInsetsGeometry.only(bottom: 12.h),
                        ),
                        itemCount: category.adhkarList.length,
                        itemBuilder: (context, index) {
                          final item = category.adhkarList[index];
                          return Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.orange,
                                  radius: 20.r,
                                  child: Text(
                                    '${index + 1}',
                                    style: AppStyles.font16RegularWhiteColor,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.text,
                                        style: AppStyles.font16RegularGreyColor
                                            .copyWith(
                                              color: AppColors.blackColor,
                                            ),
                                      ),
                                      SizedBox(height: 8.h),
                                      /*Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.yellowColor,
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8.w,
                                          vertical: 2.h,
                                        ),
                                        child: Text(
                                          'رواه مسلم',
                                          style: AppStyles.font18MediumBlackColor,
                                        ),
                                      ),
                                      SizedBox(height: 8.h,),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColors.primaryColor
                                                .withOpacity(0.12),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8.w,
                                          vertical: 2.h,
                                        ),
                                        child: Text(
                                          'حفظ من شر اليوم',
                                          style: AppStyles.font18MediumBlackColor,
                                        ),
                                      ),*/
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16.w,
                                          vertical: 8.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor,
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.repeat,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                            SizedBox(width: 8.w),
                                            Text(
                                              "التكرار: ${item.count}",
                                              style: AppStyles
                                                  .font16RegularWhiteColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.favorite_border_outlined,
                                    color: AppColors.greyColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
