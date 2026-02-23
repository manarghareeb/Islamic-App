import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';

class ReminderIconSelector extends StatelessWidget {
  final List<IconData> icons;
  final int selectedIcon;
  final Function(int) onSelect;

  const ReminderIconSelector({
    super.key,
    required this.icons,
    required this.selectedIcon,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: List.generate(icons.length, (index) {
        final isSelected = index == selectedIcon;
        return GestureDetector(
          onTap: () => onSelect(index),
          child: Container(
            width: 86.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primaryColor.withOpacity(0.1)
                  : Colors.white,
              border: Border.all(
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.primaryColor.withOpacity(0.12),
              ),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Icon(
              icons[index],
              color: isSelected
                  ? AppColors.primaryColor
                  : AppColors.blackColor,
            ),
          ),
        );
      }),
    );
  }
}