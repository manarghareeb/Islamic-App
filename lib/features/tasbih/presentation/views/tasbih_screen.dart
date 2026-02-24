import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/core/widgets/custom_app_bar.dart';
import 'package:islamic_app/core/widgets/custom_button_widget.dart';
import 'package:islamic_app/core/widgets/custom_gradient_card.dart';
import 'package:islamic_app/features/tasbih/presentation/widgets/counter_with_title.dart';

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({super.key});

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> {
  List<String> tasbihPhrases = [
    'سبحان الله',
    'الحمد لله',
    'الله أكبر',
    'لا إله إلا الله',
  ];

  int selectedIndex = 0;
  int currentCount = 0;
  int totalRounds = 0;
  final int target = 33;

  void incrementTasbih() {
    setState(() {
      currentCount++;
      if (currentCount >= target) {
        currentCount = 0;
        totalRounds++;
      }
    });
  }

  void resetTasbih() {
    setState(() {
      currentCount = 0;
      totalRounds = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress = currentCount / target;
    final currentPhrase = tasbihPhrases[selectedIndex];
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15.w,
                    mainAxisSpacing: 15.h,
                    childAspectRatio: 2.5,
                  ),
                  itemCount: tasbihPhrases.length,
                  itemBuilder: (context, index) {
                    final isSelected = index == selectedIndex;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          currentCount = 0;
                          totalRounds = 0;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryColor.withOpacity(0.12)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primaryColor
                                : Colors.transparent,
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            tasbihPhrases[index],
                            style: AppStyles.font18MediumBlackColor.copyWith(
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.blackColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 25.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(32.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: AppColors.primaryColor.withOpacity(0.16),
                      width: 2.w,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 25,
                        offset: const Offset(0, 20),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        currentPhrase,
                        style: AppStyles.font30MediumWhiteColor.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 180.w,
                            height: 180.h,
                            child: CircularProgressIndicator(
                              value: progress,
                              strokeWidth: 8,
                              backgroundColor: Colors.grey.withOpacity(0.1),
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                '$currentCount',
                                style: AppStyles.font24MediumBlackColor
                                    .copyWith(fontSize: 48.sp),
                              ),
                              Text(
                                'من $target',
                                style: AppStyles.font12RegularGreyColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 32.h),
                      GestureDetector(
                        onTap: incrementTasbih,
                        child: Container(
                          width: 120.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryColor.withOpacity(0.5),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'تسبيح',
                                  style: AppStyles.font14RegularWhiteColor
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'اضغط للعد',
                                  style: AppStyles.font12RegularGreyColor
                                      .copyWith(
                                        color: Colors.white70,
                                        fontSize: 10.sp,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 56.h),
                      Divider(color: AppColors.primaryColor.withOpacity(0.2)),
                      SizedBox(height: 15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CounterWithTitle(
                            title: 'الجولات',
                            count: '$totalRounds',
                          ),
                          SizedBox(width: 24.w),
                          CounterWithTitle(
                            title: 'الإجمالي اليوم',
                            count: '${(totalRounds * target) + currentCount}',
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: CustomButtonWidget(
                              iconColor: AppColors.blackColor,
                              icon: Icons.refresh,
                              textStyle: AppStyles.font14MediumBlackColor,
                              backgroundColor: AppColors.whiteBackgroundColor,
                              bordercolor: AppColors.primaryColor.withOpacity(
                                0.12,
                              ),
                              shadowColor: Colors.transparent,
                              title: 'إعادة تعيين',
                              onPressed: resetTasbih,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.h),
                const CustomGradientCard(
                  title: 'فضل التسبيح',
                  text:
                      '"مَنْ قَالَ سُبْحَانَ اللَّهِ وَبِحَمۡدِهِ فِي يَوۡمٍ مِائَةَ مَرَّةٍ حُطَّتۡ خَطَايَاهُ وَإِنۡ كَانَتۡ مِثۡلَ زَبَدِ ٱلۡبَحۡرِ"',
                  referance: 'رواه البخاري ومسلم',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
