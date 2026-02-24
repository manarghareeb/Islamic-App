import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';

class LinearProgressIndicatorWidget extends StatelessWidget {
  const LinearProgressIndicatorWidget({
    super.key, required this.progressValue,
  });
  final double progressValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10.h,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return AnimatedContainer( 
                duration: const Duration(milliseconds: 500),
                width: constraints.maxWidth * progressValue, 
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.yellowColor,
                      AppColors.primaryColor,
                    ],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
