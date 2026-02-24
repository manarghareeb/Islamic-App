import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:islamic_app/core/routing/app_router.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/widgets/custom_gradient_card.dart';
import 'package:islamic_app/core/widgets/custom_header.dart';
import 'package:islamic_app/features/home/presentation/widgets/horizontal_service_item.dart';
import 'package:islamic_app/features/home/presentation/widgets/prayer_times_card.dart';
import 'package:islamic_app/features/home/presentation/widgets/service_item.dart';
import 'package:islamic_app/features/prayer_times/presentation/cubit/prayer_cubit.dart';
import 'package:islamic_app/features/prayer_times/presentation/cubit/prayer_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerCubit, PrayerState>(
      builder: (context, state) {
        final prayerData = state is PrayerSuccess ? state.prayerData : null;
        final List<Map<String, dynamic>> servicesList = [
          {
            'title': 'الأذان',
            'subtitle': 'مواقيت الصلاة',
            'icon': Icons.access_time,
            'colors': false,
            'onTap': () => GoRouter.of(
              context,
            ).push(AppRouter.payerTimesScreen, extra: prayerData),
          },
          {
            'title': 'المصحف',
            'subtitle': 'قراءة القرآن الكريم',
            'icon': Icons.book,
            'colors': true,
            'onTap': () => GoRouter.of(context).push(AppRouter.quranScreen),
          },
          {
            'title': 'التذكيرات',
            'subtitle': 'تنبيهات يومية',
            'icon': Icons.notifications_none,
            'colors': false,
            'onTap': () => GoRouter.of(context).push(AppRouter.remindersScreen),
          },
          {
            'title': 'الأدعية والأذكار',
            'subtitle': 'حصن المسلم',
            'icon': Icons.front_hand,
            'colors': true,
            'onTap': () => GoRouter.of(context).push(AppRouter.athkarScreen),
          },
          {
            'title': 'المساجد',
            'subtitle': 'أقرب المساجد',
            'icon': Icons.location_on,
            'colors': false,
            'onTap': () {},
          },
          {
            'title': 'تعليم القرآن',
            'subtitle': 'دروس وتلاوات',
            'icon': Icons.headphones,
            'colors': true,
            'onTap': () {},
          },
        ];
        return Scaffold(
          backgroundColor: AppColors.whiteBackgroundColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: state is PrayerLoading
                          ? SizedBox(
                              height: 200.h,
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : state is PrayerError
                          ? SizedBox(
                              height: 200.h,
                              child: Center(
                                child: Text('حدث خطأ في تحميل مواقيت الصلاة'),
                              ),
                            )
                          : CustomHeader(
                              widget: PrayerTimesCard(prayerData: prayerData),
                              isHome: true,
                              isAthkar: false,
                              mediaHeight: 0.6,
                              title: 'المصحف الشريف',
                              subTitle: 'السلام عليكم ورحمة الله',
                            ),
                    ),
                    /*Positioned(
                      top: MediaQuery.of(context).size.height * 0.55,
                      left: 20.w,
                      right: 20.w,
                      child: const AyahOfTheDayCard(),
                    ),*/
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                  child: const CustomGradientCard(title: 'آية اليوم'),
                ),
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15.h,
                      crossAxisSpacing: 15.w,
                      childAspectRatio: 1.1,
                    ),
                    itemCount: servicesList.length,
                    itemBuilder: (context, index) {
                      final item = servicesList[index];
                      return ServiceItem(
                        title: item['title'],
                        subtitle: item['subtitle'],
                        icon: item['icon'],
                        isPrimary: item['colors'],
                        onTap: item['onTap'],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      HorizontalServiceItem(
                        title: 'المسبحة',
                        subtitle: 'عداد التسبيح',
                        icon: Icons.circle_outlined,
                        onTap: () =>
                            GoRouter.of(context).push(AppRouter.tasbihScreen),
                      ),
                      SizedBox(height: 15.h),
                      HorizontalServiceItem(
                        title: 'اتجاه القبلة',
                        subtitle: 'تحديد اتجاه القبلة',
                        icon: Icons.explore,
                        color: [
                          AppColors.yellowColor,
                          AppColors.darkYellowColor,
                        ],
                        onTap: () {},
                      ),
                      SizedBox(height: 30.h),
                    ],
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
