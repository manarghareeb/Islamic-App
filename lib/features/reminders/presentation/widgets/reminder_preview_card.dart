import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/core/widgets/gradient_icon_container.dart';

class ReminderPreviewCard extends StatelessWidget {
  const ReminderPreviewCard({
    super.key,
    required this.icons,
    required this.selectedIcon,
    required this.titleController,
    required this.selectedTime,
  });

  final List<IconData> icons;
  final int selectedIcon;
  final TextEditingController titleController;
  final TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentGeometry.topLeft,
          end: AlignmentGeometry.bottomRight,
          colors: const [Color(0xFFE8F5F1), Color(0xFFF4E5C2)],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'معاينة التذكير',
            style: AppStyles.font12RegularGreyColor,
          ),
          SizedBox(height: 36.h),
          Row(
            children: [
              GradientIconContainer(
                width: 48.w,
                height: 48.h,
                isBorder: true,
                radius: 20.r,
                icon: icons[selectedIcon],
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          titleController.text.isEmpty
                              ? "عنوان التذكير"
                              : titleController.text,
                          style: AppStyles.font18MediumBlackColor
                              .copyWith(fontSize: 16.sp),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 14.sp,
                              color: AppColors.greyColor,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              selectedTime == null
                                  ? "وقت التذكير"
                                  : selectedTime!.format(context),
                              style:
                                  AppStyles.font12RegularGreyColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}