import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/features/tasbih/domain/entities/tasbih_entity.dart';

class TasbihDropdown extends StatelessWidget {
  final List<TasbihEntity> tasbihs;
  final TasbihEntity currentTasbih;
  final ValueChanged<TasbihEntity> onChanged;

  const TasbihDropdown({
    super.key,
    required this.tasbihs,
    required this.currentTasbih,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      borderRadius: BorderRadius.circular(25.r),
      dropdownColor: Colors.white,
      value: currentTasbih.phrase,
      items: tasbihs.map((t) {
        return DropdownMenuItem(
          value: t.phrase,
          child: Text(
            t.phrase,
            style: AppStyles.font14MediumBlackColor,
          ),
        );
      }).toList(),
      onChanged: (value) {
        final selected = tasbihs.firstWhere((t) => t.phrase == value);
        onChanged(selected);
      },
      decoration: InputDecoration(
        labelText: 'اختر الذكر',
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.r),
          borderSide: BorderSide(
            color: AppColors.primaryColor.withOpacity(0.2),
            width: 2.w,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.r),
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: 2.w,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 10.h,
        ),
      ),
    );
  }
}