import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/core/widgets/custom_button_widget.dart';
import 'package:islamic_app/features/reminders/presentation/widgets/add_title_field%20.dart';
import 'package:islamic_app/features/tasbih/presentation/cubit/tasbih_cubit.dart';

class AddTasbihDialog extends StatelessWidget {
  const AddTasbihDialog({
    super.key,
    required this.controller,
    required this.cubit,
  });

  final TextEditingController controller;
  final TasbihCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        backgroundColor: AppColors.whiteBackgroundColor,
        title: Text('إضافة ذكر جديد', style: AppStyles.font24MediumBlackColor),
        content: AddTitleField(
          title: "عنوان الذكر",
          hintText: "مثال: سبحان الله وبحمده...",
          controller: controller,
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: CustomButtonWidget(
                  title: 'إضافة',
                  onPressed: () {
                    if (controller.text.trim().isNotEmpty) {
                      cubit.addTasbih(controller.text.trim());
                      Navigator.pop(context);
                    }
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
          ),
        ],
      ),
    );
  }
}
