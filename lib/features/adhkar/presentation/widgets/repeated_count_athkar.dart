import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/features/adhkar/domain/entities/adhkar_item_entity.dart';

class RepeatedCountAthkar extends StatelessWidget {
  const RepeatedCountAthkar({
    super.key,
    required this.item,
  });

  final AdhkarItemEntity item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          item.text,
          style: AppStyles.font16RegularGreyColor
              .copyWith(
                color: AppColors.blackColor,
              ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 8.h,
          ),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(
              12.r,
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.repeat,
                color: Colors.white,
                size: 16,
              ),
              SizedBox(width: 8.w),
              Text(
                "التكرار: ${item.count}",
                style: AppStyles
                    .font16RegularWhiteColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
