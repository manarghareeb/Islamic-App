import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/core/widgets/custom_button_widget.dart';
import 'package:islamic_app/features/reminders/domain/entities/reminder_entity.dart';

class ReminderDialogButtons extends StatelessWidget {
  const ReminderDialogButtons({
    super.key,
    required this.titleController,
    required this.selectedTime,
    required this.icons,
    required this.selectedIcon,
    required this.colors,
    required this.selectedColor,
  });

  final TextEditingController titleController;
  final TimeOfDay? selectedTime;
  final List<IconData> icons;
  final int selectedIcon;
  final List<List<Color>> colors;
  final int selectedColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButtonWidget(
            title: 'حفظ التذكير',
            onPressed: () {
              if (titleController.text.isEmpty ||
                  selectedTime == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "من فضلك أدخل العنوان والوقت أولًا",
                    ),
                  ),
                );
                return;
              }
              final newReminder = ReminderEntity(
                title: titleController.text,
                time: selectedTime!.format(context),
                iconCode: icons[selectedIcon].codePoint,
                gradientColor: colors[selectedColor]
                    .map((c) => c.value)
                    .toList(),
                isActive: true,
              );
              Navigator.pop(context, newReminder);
            },
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: CustomButtonWidget(
            title: 'إلغاء',
            onPressed: () => Navigator.pop(context),
            backgroundColor: Colors.white,
            bordercolor: AppColors.primaryColor.withOpacity(0.12),
            textStyle: AppStyles.font14MediumBlackColor,
            shadowColor: Colors.transparent,
          ),
        ),
      ],
    );
  }
}