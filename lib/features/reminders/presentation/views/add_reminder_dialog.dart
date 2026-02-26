import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/features/reminders/presentation/widgets/add_title_field%20.dart';
import 'package:islamic_app/features/reminders/presentation/widgets/reminder_color_selector.dart';
import 'package:islamic_app/features/reminders/presentation/widgets/reminder_dialog_buttons.dart';
import 'package:islamic_app/features/reminders/presentation/widgets/reminder_icon_selector.dart';
import 'package:islamic_app/features/reminders/presentation/widgets/reminder_preview_card.dart';
import 'package:islamic_app/features/reminders/presentation/widgets/reminder_time_picker.dart';

class AddReminderDialog extends StatefulWidget {
  const AddReminderDialog({super.key});

  @override
  State<AddReminderDialog> createState() => _AddReminderDialogState();
}

class _AddReminderDialogState extends State<AddReminderDialog> {
  final TextEditingController titleController = TextEditingController();
  TimeOfDay? selectedTime;
  int selectedIcon = 0;
  int selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    List<List<Color>> colors = [
      [Colors.pinkAccent, Colors.pinkAccent.withOpacity(0.5)],
      [Colors.purpleAccent, Colors.purpleAccent.withOpacity(0.5)],
      [Colors.blueAccent, Colors.blueAccent.withOpacity(0.5)],
      [Colors.amber, Colors.amber.withOpacity(0.5)],
      [AppColors.primaryColor, AppColors.primaryColor.withOpacity(0.5)],
    ];
    List<IconData> icons = [
      Icons.notifications_none,
      Icons.favorite_border,
      Icons.access_time,
      Icons.nightlight_outlined,
      Icons.light_mode_outlined,
      Icons.star_border_outlined,
    ];

    return Dialog(
      backgroundColor: AppColors.whiteBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: AppColors.blackColor,
                      size: 20.sp,
                    ),
                  ),
                ),
                SizedBox(height: 23.h),
                Text(
                  "إضافة تذكير جديد",
                  style: AppStyles.font24MediumBlackColor,
                ),
                SizedBox(height: 25.h),
                AddTitleField(
                  title: "عنوان التذكير",
                  hintText: "مثال: صلاة الضحى، قراءة ورد...",
                  controller: titleController,
                ),
                SizedBox(height: 15.h),
                ReminderTimePicker(
                  selectedTime: selectedTime,
                  onTimePicked: (time) => setState(() => selectedTime = time),
                ),
                SizedBox(height: 24.h),
                Text("اختر الأيقونة", style: AppStyles.font14MediumBlackColor),
                SizedBox(height: 12.h),
                ReminderIconSelector(
                  icons: icons,
                  selectedIcon: selectedIcon,
                  onSelect: (index) => setState(() => selectedIcon = index),
                ),
                SizedBox(height: 24.h),
                Text("اختر اللون", style: AppStyles.font14MediumBlackColor),
                SizedBox(height: 14.h),
                ReminderColorSelector(
                  colors: colors,
                  selectedColor: selectedColor,
                  onSelect: (index) => setState(() => selectedColor = index),
                ),
                SizedBox(height: 24.h),
                ReminderPreviewCard(
                  icons: icons,
                  selectedIcon: selectedIcon,
                  titleController: titleController,
                  selectedTime: selectedTime,
                ),
                SizedBox(height: 24.h),
                ReminderDialogButtons(
                  titleController: titleController,
                  selectedTime: selectedTime,
                  icons: icons,
                  selectedIcon: selectedIcon,
                  colors: colors,
                  selectedColor: selectedColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
