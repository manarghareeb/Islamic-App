import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/widgets/custom_header.dart';
import 'package:islamic_app/features/adhkar/presentation/widgets/athkar_card.dart';
import 'package:islamic_app/features/adhkar/presentation/widgets/info_card.dart';

class AthkarScreen extends StatelessWidget {
  const AthkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<AthkarCategory> categories = [
      AthkarCategory(
        name: "أذكار الصباح",
        count: "5 ذكر",
        color: Colors.orange,
        icon: "☀️",
        //onTap: ()=> context.push(AppRouter.athkarDetailsScreen),
      ),
      AthkarCategory(
        name: "أذكار المساء",
        count: "3 ذكر",
        color: Colors.purple,
        icon: "🌙",
        //onTap: (){}
      ),
      AthkarCategory(
        name: "أذكار النوم",
        count: "3 ذكر",
        color: Colors.blue,
        icon: "🌃",
        //onTap: () {},
      ),
      AthkarCategory(
        name: "أذكار بعد الصلاة",
        count: "5 ذكر",
        color: Colors.teal,
        icon: "🕌",
        //onTap: () {},
      ),
      AthkarCategory(
        name: "أدعية يومية",
        count: "3 ذكر",
        color: Colors.pink,
        icon: "🙌",
        //onTap: () {},
      ),
      AthkarCategory(
        name: "آيات للحفظ",
        count: "3 ذكر",
        color: Colors.orangeAccent,
        icon: "📖",
        //onTap: () {},
      ),
    ];
    return Scaffold(
      backgroundColor: AppColors.whiteBackgroundColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
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
                    child: InfoCard(title: 'الفئات', value: '6'),
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
                  //childAspectRatio: 1,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return AthkarCard(category: categories[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class AthkarCategory {
  final String name;
  final String count;
  final Color color;
  final String icon;
  //final VoidCallback onTap;

  AthkarCategory({
    required this.name,
    required this.count,
    required this.color,
    required this.icon, 
    //required this.onTap,
  });
}
