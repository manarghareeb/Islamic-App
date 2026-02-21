import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/features/onboarding/presentation/widgets/buttons_row.dart';
import 'package:islamic_app/features/onboarding/presentation/widgets/custom_smooth_page_indicator.dart';
import 'package:islamic_app/features/onboarding/presentation/widgets/page_view_body.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();
  int index = 0;

  final List<Map<String, dynamic>> pages = [
    {
      'title': 'القرآن الكريم',
      'subtitle':
          'اقرأ القرآن الكريم بخط واضح وتصميم جميل مع إمكانية الاستماع للتلاوات',
      'button': 'التالي',
      'icon': Icons.menu_book_rounded,
      'color': AppColors.primaryColor,
      'gradientColor': [
        AppColors.primaryColor,
        AppColors.primaryColor,
        AppColors.darkPrimaryColor,
      ],
    },
    {
      'title': 'مواقيت الصلاة',
      'subtitle': 'تنبيهات دقيقة لمواقيت الصلاة حسب موقعك مع صوت الأذان',
      'button': 'التالي',
      'icon': Icons.access_time_rounded,
      'color': AppColors.yellowColor,
      'gradientColor': [
        AppColors.yellowColor,
        AppColors.yellowColor,
        AppColors.darkYellowColor,
      ],
    },
    {
      'title': 'رفيقك الروحاني',
      'subtitle':
          'تذكيرات يومية، أذكار، تسبيح، وكل ما تحتاجه في رحلتك الإيمانية',
      'button': 'ابدأ الآن',
      'icon': Icons.favorite_border_rounded,
      'color': AppColors.primaryColor,
      'gradientColor': [
        AppColors.primaryColor,
        AppColors.primaryColor,
        AppColors.darkPrimaryColor,
      ],
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.whiteBackgroundColor,
        body: Stack(
          children: [
            Positioned(
              left: MediaQuery.of(context).size.width * 0.45,
              bottom: MediaQuery.of(context).size.height * 0.6,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 3,
                    color: AppColors.greyColor.withOpacity(0.04),
                  ),
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.05,
              bottom: MediaQuery.of(context).size.height * 0.07,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.9,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 3,
                    color: AppColors.greyColor.withOpacity(0.04),
                  ),
                ),
              ),
            ),
            Positioned(
              right: MediaQuery.of(context).size.width * 0.45,
              bottom: -220,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 3,
                    color: AppColors.greyColor.withOpacity(0.04),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: controller,
                    itemCount: pages.length,
                    onPageChanged: (pageIndex) {
                      setState(() {
                        index = pageIndex;
                      });
                    },
                    itemBuilder: (context, index) {
                      final page = pages[index];
                      return PageViewBody(page: page);
                    },
                  ),
                ),
                CustomSmoothPageIndicator(
                  controller: controller,
                  count: pages.length,
                  activeColor: pages[index]['color'],
                ),
                SizedBox(height: 130.h),
                Divider(color: AppColors.primaryColor.withOpacity(0.12)),
                ButtonsRow(
                  controller: controller,
                  pagesLength: pages.length,
                  currentIndex: index,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
