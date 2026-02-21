import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:islamic_app/core/routing/app_router.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';

class QuranListView extends StatelessWidget {
  final List qurans;

  const QuranListView({super.key, required this.qurans});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 20.w),
      itemCount: qurans.length,
      itemBuilder: (context, index) {
        final quran = qurans[index];
        return GestureDetector(
          onTap: () => GoRouter.of(
            context,
          ).push(AppRouter.quranDetailsScreen, extra: quran),
          child: Container(
            margin: EdgeInsets.only(bottom: 10.h),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFFE8F3EF),
                  child: Text(
                    '${quran.number}',
                    style: const TextStyle(
                      color: Color(0xFF0C724C),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 15.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(quran.name, style: AppStyles.font18MediumBlackColor),
                    Text(
                      '${quran.englishName} · ${quran.numberOfAyahs} آية',
                      style: AppStyles.font12RegularGreyColor,
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: quran.revelationType == 'Meccan'
                          ? AppColors.primaryColor.withOpacity(0.1)
                          : AppColors.yellowColor.withOpacity(0.1),
                  ),
                  child: Text(
                    quran.revelationType == 'Meccan' ? 'مكية' : 'مدنية',
                    style: TextStyle(
                      color: quran.revelationType == 'Meccan'
                          ? AppColors.primaryColor
                          : AppColors.yellowColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
