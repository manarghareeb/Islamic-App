import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:islamic_app/core/routing/app_router.dart';
import 'package:islamic_app/core/theme/colors.dart';

class SplashDotsIndicator extends StatefulWidget {
  const SplashDotsIndicator({super.key});

  @override
  State<SplashDotsIndicator> createState() => _SplashDotsIndicatorState();
}

class _SplashDotsIndicatorState extends State<SplashDotsIndicator> {
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        activeIndex = (activeIndex + 1) % 3;
      });

      if (timer.tick == 3) {
        timer.cancel();
        GoRouter.of(context).go(AppRouter.onboardingScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          final isActive = index == activeIndex;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            width: isActive ? 10.w : 8.w,
            height: isActive ? 10.w : 8.w,
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.yellowColor
                  : AppColors.yellowColor.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
          );
        }),
      ),
    );
  }
}
