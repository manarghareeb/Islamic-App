import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/core/widgets/gradient_icon_container.dart';
import 'package:islamic_app/features/quran/domain/entities/quran_entity.dart';
import 'package:islamic_app/features/quran/presentation/cubit/ayah_cubit/ayah_cubit.dart';
import 'package:islamic_app/features/quran/presentation/cubit/ayah_cubit/ayah_state.dart';

class QuranDetailsScreen extends StatelessWidget {
  final QuranEntity initialQuranData;
  const QuranDetailsScreen({super.key, required this.initialQuranData});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.whiteBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () => GoRouter.of(context).pop(),
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
          ),
          title: Column(
            children: [
              Text(
                initialQuranData.name,
                style: AppStyles.font24MediumBlackColor.copyWith(
                  color: Colors.white,
                ),
              ),
              Text(
                '${initialQuranData.revelationType == 'Meccan' ? 'مكية' : 'مدنية'} - ${initialQuranData.numberOfAyahs} آية',
                style: AppStyles.font14RegularWhiteColor,
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.volume_up),
              onPressed: () {},
              color: Colors.white,
              iconSize: 20.sp,
            ),
            IconButton(
              icon: const Icon(Icons.bookmark_border),
              onPressed: () {},
              color: Colors.white,
              iconSize: 20.sp,
            ),
          ],
        ),
        body: Column(
          children: [
            /*Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.zoom_in),
                        Text('20px', style: TextStyle(fontSize: 14.sp)),
                        const Icon(Icons.zoom_out),
                        const VerticalDivider(),
                        const Text('العربية'),
                      ],
                    ),
                  ),*/
            BlocBuilder<AyahCubit, AyahState>(
              builder: (context, state) {
                if (state is AyahLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  );
                } else if (state is AyahSuccess) {
                  final ayahs = state.quranData.ayahs ?? [];
                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(
                        left: 20.w,
                        right: 20.w,
                        top: 20.h,
                        bottom: 32.h,
                      ),
                      itemCount: ayahs.length,
                      itemBuilder: (context, index) {
                        final ayah = ayahs[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 15.h),
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: AppColors.primaryColor.withOpacity(0.06),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                  ayah.text,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Amiri',
                                  ),
                                ),
                              ),
                              SizedBox(width: 15.w),
                              GradientIconContainer(
                                width: 40.w,
                                height: 40.h,
                                isText: true,
                                text: '${ayah.numberInSurah}',
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is AyahError) {
                  print(state.message);
                  return Center(child: Text(state.message));
                }
                return const SizedBox();
              },
            ),
            /*Padding(
                    padding: EdgeInsets.all(15.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0C724C),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            child: const Text('السورة التالية'),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            child: const Text('السورة السابقة'),
                          ),
                        ),
                      ],
                    ),
                  ),*/
          ],
        ),
      ),
    );
  }
}
