import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/features/quran/presentation/cubit/quran_cubit/quran_cubit.dart';
import 'package:islamic_app/features/quran/presentation/cubit/quran_cubit/quran_state.dart';
import 'package:islamic_app/features/quran/presentation/widgets/quran_list_view.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBackgroundColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocBuilder<QuranCubit, QuranState>(
          builder: (context, state) {
            return Column(
              children: [
                Container(
                  height: 220.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 40.h,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        AppColors.primaryColor,
                        AppColors.primaryColor,
                        AppColors.darkPrimaryColor,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () => GoRouter.of(context).pop(),
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                'القرآن الكريم',
                                style: AppStyles.font24MediumBlackColor
                                    .copyWith(color: Colors.white),
                              ),
                              Text(
                                '114 سورة',
                                style: AppStyles.font14RegularWhiteColor,
                              ),
                            ],
                          ),
                          const SizedBox(width: 24),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        height: 44.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white30),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: TextField(
                          autocorrect: false,
                          enableSuggestions: false,
                          onChanged: (value) {
                            context.read<QuranCubit>().searchQuran(value);
                          },
                          cursorColor: Colors.white60,
                          style: AppStyles.font16RegularWhiteColor,
                          decoration: InputDecoration(
                            hintText: 'ابحث عن سورة...',
                            hintStyle: AppStyles.font14RegularWhiteColor
                                .copyWith(color: Colors.white60),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.white60,
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: BlocBuilder<QuranCubit, QuranState>(
                    builder: (context, state) {
                      if (state is QuranLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF0C724C),
                          ),
                        );
                      } else if (state is QuranSuccess) {
                        if (state.qurans.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 80.sp,
                                  color: Colors.grey[400],
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  'لا توجد سورة بهذا الاسم',
                                  style: AppStyles.font16RegularWhiteColor
                                      .copyWith(
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          );
                        }
                        return QuranListView(qurans: state.qurans);
                      } else if (state is QuranError) {
                        return Center(child: Text(state.message));
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
