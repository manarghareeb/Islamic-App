import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/widgets/custom_app_bar.dart';
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
        appBar: CustomAppBar(
          title: initialQuranData.name,
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
          subTitle:
              '${initialQuranData.revelationType == 'Meccan' ? 'مكية' : 'مدنية'} - ${initialQuranData.numberOfAyahs} آية',
        ),
        body: Column(
          children: [
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
                  const String basmalah =
                      "بِسۡمِ ٱللَّهِ ٱلرَّحۡمَـٰنِ ٱلرَّحِیمِ";
                  return Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFBEA),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            children: [
                              if (initialQuranData.number != 9)
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 25.h,
                                    top: 10.h,
                                  ),
                                  child: Text(
                                    basmalah,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 26.sp,
                                      fontFamily: 'Amiri',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              Text.rich(
                                textAlign: TextAlign.justify,
                                textDirection: TextDirection.rtl,
                                TextSpan(
                                  children: [
                                    for (var i = 0; i < ayahs.length; i++) ...[
                                      TextSpan(
                                        text:
                                            (i == 0 &&
                                                initialQuranData.number != 1)
                                            ? "${ayahs[i].text.replaceFirst(basmalah, "").trim()} "
                                            : "${ayahs[i].text} ",
                                        style: TextStyle(
                                          fontSize: 24.sp,
                                          height: 2.2,
                                          fontFamily: 'Amiri',
                                          color: Colors.black.withOpacity(0.8),
                                        ),
                                      ),
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 4.w,
                                          ),
                                          width: 32.w,
                                          height: 32.w,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey.withOpacity(
                                              0.15,
                                            ),
                                            border: Border.all(
                                              color: const Color(0xFFB59410),
                                              width: 0.8,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '${ayahs[i].numberInSurah}',
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'sans-serif',
                                                color: const Color(0xFFB59410),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (state is AyahError) {
                  print(state.message);
                  return Center(child: Text(state.message));
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
