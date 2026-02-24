import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/widgets/custom_header.dart';
import 'package:islamic_app/features/adhkar/presentation/cubit/adhkar_cubit.dart';
import 'package:islamic_app/features/adhkar/presentation/cubit/adhkar_state.dart';
import 'package:islamic_app/features/adhkar/presentation/widgets/athkar_card.dart';
import 'package:islamic_app/features/adhkar/presentation/widgets/info_card.dart';

class AthkarScreen extends StatelessWidget {
  const AthkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBackgroundColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocBuilder<AdhkarCubit, AdhkarState>(
          builder: (context, state) {
            if (state is AdhkarLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AdhkarSuccess) {
              final categories = state.categories;
              return Column(
                children: [
                  CustomHeader(
                    mediaHeight: 0.3,
                    title: "الأدعية والأذكار",
                    subTitle: "حصن المسلم اليومي",
                    isHome: false,
                    isAthkar: true,
                    widget: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: InfoCard(
                            title: 'الفئات', 
                            value: categories.length.toString(), 
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: InfoCard(title: 'مكتملة اليوم', value: '0'),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: InfoCard(title: 'المفضلة', value: '0'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.all(20.w),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.w,
                        mainAxisSpacing: 15.h,
                        //childAspectRatio: 1.1,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return AthkarCard(
                          category: categories[index], 
                          index: index,
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is AdhkarError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message, style: const TextStyle(color: Colors.red)),
                    ElevatedButton(
                      onPressed: () => context.read<AdhkarCubit>().fetchAllAdhkar(),
                      child: const Text("إعادة المحاولة"),
                    )
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
