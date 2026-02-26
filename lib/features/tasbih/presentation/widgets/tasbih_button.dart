import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/features/tasbih/domain/entities/tasbih_entity.dart';
import 'package:islamic_app/features/tasbih/presentation/cubit/tasbih_cubit.dart';

class TasbihButton extends StatelessWidget {
  const TasbihButton({
    super.key,
    required this.cubit,
    required this.currentTasbih,
    required this.target,
  });

  final TasbihCubit cubit;
  final TasbihEntity currentTasbih;
  final int target;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => cubit.incrementTasbih(currentTasbih, target),
      child: Container(
        width: 120.w,
        height: 120.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'تسبيح',
                style: AppStyles.font14RegularWhiteColor.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'اضغط للعد',
                style: AppStyles.font12RegularGreyColor.copyWith(
                  color: Colors.white70,
                  fontSize: 10.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
