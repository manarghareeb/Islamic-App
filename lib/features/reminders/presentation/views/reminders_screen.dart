import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/core/widgets/custom_app_bar.dart';
import 'package:islamic_app/features/reminders/presentation/cubit/reminders_cubit.dart';
import 'package:islamic_app/features/reminders/presentation/cubit/reminders_stare.dart';
import 'package:islamic_app/features/reminders/presentation/views/add_reminder_dialog.dart';
import 'package:islamic_app/features/reminders/presentation/widgets/advice_card.dart';
import 'package:islamic_app/features/reminders/presentation/widgets/reminder_card.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  Future<void> openAddReminderDialog() async {
    final result = await showDialog(
      context: context,
      builder: (context) => const AddReminderDialog(),
    );

    if (result != null) {
      context.read<RemindersCubit>().addReminder(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.whiteBackgroundColor,
        appBar: CustomAppBar(
          title: 'التذكيرات',
          subTitle: '',
          actions: [
            GestureDetector(
              onTap: openAddReminderDialog,
              child: CircleAvatar(
                radius: 20.r,
                backgroundColor: Colors.white24,
                child: Icon(Icons.add, color: Colors.white, size: 15.sp),
              ),
            ),
            SizedBox(width: 12.w),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(
              children: [
                BlocBuilder<RemindersCubit, RemindersState>(
                  builder: (context, state) {
                    if (state is RemindersLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is RemindersLoaded) {
                      final reminders = state.reminders;

                      if (reminders.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 40.h),
                          child: Text(
                            "لا توجد تذكيرات حالياً",
                            style: AppStyles.font16RegularWhiteColor.copyWith(
                              color: AppColors.greyColor,
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: reminders.length,
                        itemBuilder: (context, index) {
                          final reminder = reminders[index];
                          return ReminderCard(
                            key: ValueKey(reminder.title + reminder.time),
                            title: reminder.title,
                            time: reminder.time,
                            icon: IconData(
                              reminder.iconCode,
                              fontFamily: 'MaterialIcons',
                            ),
                            gradientColor: reminder.gradientColor
                                .map((c) => Color(c))
                                .toList(),
                            isActive: reminder.isActive,
                            onToggle: (newValue) {
                              context.read<RemindersCubit>().toggleReminderStatus(index, reminder);
                            },
                          );
                        },
                      );
                    } else if (state is RemindersError) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox();
                  },
                ),
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: openAddReminderDialog,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: AppColors.primaryColor.withOpacity(0.21),
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: AppColors.greyColor),
                        SizedBox(width: 12.w),
                        Text(
                          "إضافة تذكير جديد",
                          style: AppStyles.font16RegularWhiteColor.copyWith(
                            color: AppColors.greyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                const AdviceCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
