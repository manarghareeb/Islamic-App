import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/core/widgets/custom_button_widget.dart';
import 'package:islamic_app/features/tasbih/domain/entities/tasbih_entity.dart';
import 'package:islamic_app/features/tasbih/presentation/cubit/tasbih_cubit.dart';
import 'package:islamic_app/features/tasbih/presentation/widgets/counter_with_title.dart';
import 'package:islamic_app/features/tasbih/presentation/widgets/tasbih_button.dart';

class TasbihInfoSection extends StatelessWidget {
  const TasbihInfoSection({
    super.key,
    required this.currentTasbih,
    required this.progress,
    required this.target,
    required this.cubit,
  });

  final TasbihEntity currentTasbih;
  final double progress;
  final int target;
  final TasbihCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(32.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.16),
          width: 2.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 25,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            currentTasbih.phrase,
            style: AppStyles.font30MediumWhiteColor.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 24.h),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 180.w,
                height: 180.h,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 8,
                  backgroundColor: Colors.grey.withOpacity(
                    0.1,
                  ),
                  color: AppColors.primaryColor,
                ),
              ),
              Column(
                children: [
                  Text(
                    '${currentTasbih.currentCount}',
                    style: AppStyles.font24MediumBlackColor
                        .copyWith(fontSize: 48.sp),
                  ),
                  Text(
                    'من $target',
                    style: AppStyles.font12RegularGreyColor,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 32.h),
          TasbihButton(
            cubit: cubit,
            currentTasbih: currentTasbih,
            target: target,
          ),
          SizedBox(height: 56.h),
          Divider(
            color: AppColors.primaryColor.withOpacity(0.2),
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CounterWithTitle(
                title: 'الجولات',
                count: '${currentTasbih.totalRounds}',
              ),
              SizedBox(width: 24.w),
              CounterWithTitle(
                title: 'الإجمالي اليوم',
                count:
                    '${(currentTasbih.totalRounds * target) + currentTasbih.currentCount}',
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomButtonWidget(
                  iconColor: AppColors.blackColor,
                  icon: Icons.refresh,
                  textStyle: AppStyles.font14MediumBlackColor,
                  backgroundColor:
                      AppColors.whiteBackgroundColor,
                  bordercolor: AppColors.primaryColor
                      .withOpacity(0.12),
                  shadowColor: Colors.transparent,
                  title: 'إعادة تعيين',
                  onPressed: () =>
                      cubit.resetTasbih(currentTasbih),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
