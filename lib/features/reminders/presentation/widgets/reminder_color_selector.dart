import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';

class ReminderColorSelector extends StatelessWidget {
  final List<List<Color>> colors;
  final int selectedColor;
  final Function(int) onSelect;

  const ReminderColorSelector({
    super.key,
    required this.colors,
    required this.selectedColor,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: List.generate(colors.length, (index) {
        final isSelected = index == selectedColor;
        return GestureDetector(
          onTap: () => onSelect(index),
          child: Container(
            margin: EdgeInsets.only(left: 10.w),
            width: 50.w,
            height: 40.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors[index],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(
                color: isSelected
                    ? AppColors.blackColor
                    : Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        );
      }),
    );
  }
}