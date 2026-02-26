import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/core/widgets/custom_app_bar.dart';
import 'package:islamic_app/core/widgets/custom_gradient_card.dart';
import 'package:islamic_app/core/widgets/gradient_icon_container.dart';
import 'package:islamic_app/features/tasbih/domain/entities/tasbih_entity.dart';
import 'package:islamic_app/features/tasbih/presentation/cubit/tasbih_cubit.dart';
import 'package:islamic_app/features/tasbih/presentation/cubit/tasbih_state.dart';
import 'package:islamic_app/features/tasbih/presentation/widgets/add_tasbih_dialog.dart';
import 'package:islamic_app/features/tasbih/presentation/widgets/tasbih_dropdown.dart';
import 'package:islamic_app/features/tasbih/presentation/widgets/tasbih_info_section.dart';

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({super.key});

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> {
  final int target = 33;
  int selectedIndex = 0;

  void showAddTasbihDialog(BuildContext context, TasbihCubit cubit) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) =>
          AddTasbihDialog(controller: controller, cubit: cubit),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TasbihCubit>();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.whiteBackgroundColor,
        appBar: CustomAppBar(
          title: 'المسبحة الإلكترونية',
          subTitle: 'سبّح واذكر الله في كل وقت',
          actions: [
            IconButton(
              icon: const Icon(Icons.volume_up_outlined),
              onPressed: () {},
              color: Colors.white,
              iconSize: 22.sp,
            ),
          ],
        ),
        body: BlocBuilder<TasbihCubit, TasbihState>(
          builder: (context, state) {
            if (state is TasbihLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TasbihError) {
              return Center(child: Text(state.message));
            } else if (state is TasbihLoaded) {
              final tasbihs = state.tasbihs;

              if (tasbihs.isEmpty) {
                return Center(
                  child: Text(
                    'لا توجد أذكار مضافة بعد',
                    style: AppStyles.font18MediumBlackColor,
                  ),
                );
              }

              final TasbihEntity currentTasbih = tasbihs[selectedIndex];
              final progress = currentTasbih.currentCount / target;

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Expanded(
                            child: TasbihDropdown(
                              tasbihs: tasbihs,
                              currentTasbih: currentTasbih,
                              onChanged: (selectedTasbih) {
                                setState(() {
                                  selectedIndex = tasbihs.indexOf(
                                    selectedTasbih,
                                  );
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 10.w),
                          GestureDetector(
                            onTap: () => showAddTasbihDialog(context, cubit),
                            child: GradientIconContainer(
                              width: 45.w,
                              height: 45.h,
                              icon: Icons.add,
                              iconSize: 28.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25.h),
                      TasbihInfoSection(
                        currentTasbih: currentTasbih, 
                        progress: progress, 
                        target: target, 
                        cubit: cubit
                      ),
                      SizedBox(height: 25.h),
                      const CustomGradientCard(
                        title: 'فضل التسبيح',
                        text:
                            '"مَنْ قَالَ سُبْحَانَ اللَّهِ وَبِحَمْدِهِ فِي يَوْمٍ مِائَةَ مَرَّةٍ حُطَّتْ خَطَايَاهُ وَإِنْ كَانَتْ مِثْلَ زَبَدِ الْبَحْرِ"',
                        referance: 'رواه البخاري ومسلم',
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
