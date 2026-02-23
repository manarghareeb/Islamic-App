import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/core/widgets/custom_app_bar.dart';
import 'package:islamic_app/core/widgets/custom_button_widget.dart';
import 'package:islamic_app/core/widgets/custom_gradient_card.dart';
import 'package:islamic_app/core/widgets/gradient_icon_container.dart';

class TasbihScreen extends StatelessWidget {
  const TasbihScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.w,
                  mainAxisSpacing: 15.h,
                  childAspectRatio: 2.5,
                  children: [
                    _buildTasbihChip('سبحان الله', true),
                    _buildTasbihChip('الحمد لله', false),
                    _buildTasbihChip('الله أكبر', false),
                    _buildTasbihChip('لا إله إلا الله', false),
                  ],
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
                        'سبحان الله',
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
                              value: 20 / 33,
                              strokeWidth: 8,
                              backgroundColor: Colors.grey.withOpacity(0.1),
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                '20',
                                style: AppStyles.font24MediumBlackColor
                                    .copyWith(fontSize: 48.sp),
                              ),
                              Text(
                                'من 33',
                                style: AppStyles.font12RegularGreyColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 32.h),
                      GestureDetector(
                        onTap: () {},
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
                          CounterWithTitle(title: 'الجولات', count: '0'),
                          SizedBox(width: 24.w),
                          CounterWithTitle(
                            title: 'الإجمالي اليوم',
                            count: '20',
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
                              onPressed: () {},
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

  Widget _buildTasbihChip(String label, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primaryColor.withOpacity(0.12)
            : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Center(
        child: Text(label, style: AppStyles.font18MediumBlackColor),
      ),
    );
  }
}

class CounterWithTitle extends StatelessWidget {
  const CounterWithTitle({super.key, required this.title, required this.count});
  final String title;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GradientIconContainer(
          width: 48.w,
          height: 48.h,
          isText: true,
          text: count,
          textStyle: AppStyles.font24MediumBlackColor,
          gradientColor: [
            AppColors.primaryColor.withOpacity(0.1),
            AppColors.yellowColor.withOpacity(0.1),
          ],
        ),
        SizedBox(height: 8.h),
        Text(title, style: AppStyles.font12RegularGreyColor),
      ],
    );
  }
}
