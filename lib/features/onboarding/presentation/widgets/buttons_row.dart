import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:islamic_app/core/routing/app_router.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/core/widgets/custom_button_widget.dart';

class ButtonsRow extends StatelessWidget {
  const ButtonsRow({
    super.key,
    required this.controller,
    required this.pagesLength,
    required this.currentIndex,
  });

  final PageController controller;
  final int pagesLength;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Row(
        children: [
          if (currentIndex != pagesLength - 1)
            TextButton(
              onPressed: () => GoRouter.of(context).go(AppRouter.languageSelectionScreen),
              child: Text(
                'تخطي',
                style: AppStyles.font18RegularGreyColor.copyWith(
                  color: AppColors.greyColor,
                ),
              ),
            ),
          const Spacer(),
          if (currentIndex != 0)
            GestureDetector(
              onTap: () {
                if (currentIndex > 0) {
                  controller.previousPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Container(
                width: 56.w,
                height: 56.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryColor.withOpacity(0.12),
                  ),
                ),
                child: Icon(Icons.keyboard_arrow_left),
              ),
            ),
          if (currentIndex != 0) SizedBox(width: 12.w),
          CustomButtonWidget(
            width: 130.w,
            title: currentIndex == pagesLength - 1 ? 'ابدأ الآن' : 'التالي',
            backgroundColor: AppColors.primaryColor,
            onPressed: () {
              if (currentIndex == pagesLength - 1) {
                GoRouter.of(context).go(AppRouter.languageSelectionScreen);
              } else {
                controller.nextPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
