import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    required this.subTitle,
    this.actions,
  });

  final String title;
  final String subTitle;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      leading: IconButton(
        onPressed: () => GoRouter.of(context).pop(),
        icon: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
      ),
      title: Column(
        children: [
          Text(
            title,
            style: AppStyles.font24MediumBlackColor.copyWith(
              color: Colors.white,
            ),
          ),
          Text(subTitle, style: AppStyles.font14RegularWhiteColor),
        ],
      ),
      actions: actions ?? [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
