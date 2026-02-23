import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/core/widgets/custom_divider_with_shadow.dart';
import 'package:islamic_app/core/widgets/gradient_icon_container.dart';
import 'package:islamic_app/features/quran/presentation/cubit/random_ayah_cubit/random_ayah_cubit.dart';
import 'package:islamic_app/features/quran/presentation/cubit/random_ayah_cubit/random_ayah_state.dart';

class CustomGradientCard extends StatelessWidget {
  const CustomGradientCard({
    super.key,
    required this.title,
    this.text,
    this.referance,
  });
  final String title;
  final String? text;
  final String? referance;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(25.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColors.yellowColor),
            gradient: LinearGradient(
              colors: <Color>[Color(0xFFF4E5C2), Color(0xFFE8D7B0)],
              tileMode: TileMode.mirror,
            ),
          ),
          child: text != null
              ? Column(
                  children: [
                    GradientIconContainer(
                      width: 40.w,
                      height: 40.h,
                      iconSize: 20.sp,
                      icon: Icons.star,
                      gradientColor: [
                        AppColors.yellowColor,
                        AppColors.yellowColor,
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(title, style: AppStyles.font12RegularGreyColor),
                    SizedBox(height: 16.h),
                    const CustomDividerWithShadow(),
                    SizedBox(height: 16.h),
                    Text(
                      text!,
                      textAlign: TextAlign.center,
                      style: AppStyles.font24MediumBlackColor.copyWith(
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    const CustomDividerWithShadow(),
                    SizedBox(height: 16.h),
                    Text(
                      referance ?? "",
                      style: AppStyles.font14RegularWhiteColor.copyWith(
                        color: AppColors.greyColor,
                      ),
                    ),
                  ],
                )
              : BlocBuilder<RandomAyahCubit, RandomAyahState>(
                  builder: (context, state) {
                    if (state is RandomAyahLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.yellowColor,
                        ),
                      );
                    } else if (state is RandomAyahSuccess) {
                      final ayah = state.ayah;
                      return Column(
                        children: [
                          GradientIconContainer(
                            width: 40.w,
                            height: 40.h,
                            iconSize: 20.sp,
                            icon: Icons.star,
                            gradientColor: [
                              AppColors.yellowColor,
                              AppColors.yellowColor,
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Text(title, style: AppStyles.font12RegularGreyColor),
                          SizedBox(height: 16.h),
                          const CustomDividerWithShadow(),
                          SizedBox(height: 16.h),
                          Text(
                            '﴾ ${ayah.text} ﴿',
                            textAlign: TextAlign.center,
                            style: AppStyles.font24MediumBlackColor,
                          ),
                          SizedBox(height: 16.h),
                          const CustomDividerWithShadow(),
                          SizedBox(height: 16.h),
                          Text(
                            '${ayah.surahName} - آية ${ayah.numberInSurah}',
                            style: AppStyles.font14RegularWhiteColor.copyWith(
                              color: AppColors.greyColor,
                            ),
                          ),
                        ],
                      );
                    } else if (state is RandomAyahError) {
                      return Center(
                        child: Text(
                          'تعذر تحميل الآية، اسحب للتحديث',
                          style: AppStyles.font12RegularGreyColor,
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * 0.05,
          top: MediaQuery.of(context).size.height * 0.02,
          child: Container(
            width: 96.w,
            height: 96.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 8,
                color: AppColors.yellowColor.withOpacity(0.15),
              ),
            ),
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * 0.05,
          bottom: MediaQuery.of(context).size.height * 0.02,
          child: Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 8,
                color: AppColors.yellowColor.withOpacity(0.15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
