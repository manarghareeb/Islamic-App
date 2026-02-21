import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSmoothPageIndicator extends StatelessWidget {
  final int count;
  final PageController controller;
  final Color activeColor;

  const CustomSmoothPageIndicator({
    super.key,
    required this.count,
    required this.controller,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      effect: CustomizableEffect(
        spacing: 8,
        dotDecoration: DotDecoration(
          width: 8.w,
          height: 8.h,
          color: Colors.black12,
          borderRadius: BorderRadius.circular(10),
        ),
        activeDotDecoration: DotDecoration(
          width: 35.w,
          height: 8.h,
          color: activeColor,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
