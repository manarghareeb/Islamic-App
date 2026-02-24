import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:islamic_app/core/routing/app_router.dart';
import 'package:islamic_app/core/theme/styles.dart';
import 'package:islamic_app/features/adhkar/domain/entities/adhkar_category_entity.dart';

class AthkarCard extends StatelessWidget {
  const AthkarCard({super.key, required this.category, required this.index,});
  final AdhkarCategoryEntity category;
  final int index;

  Color getCategoryColor(int i) {
    const colors = [
      Colors.orange,
      Colors.purple,
      Colors.blue,
      Colors.teal,
      Colors.pink,
      Colors.orangeAccent
    ];
    return colors[i % colors.length];
  }

  String getCategoryIcon(String name) {
    if (name.contains("الصباح")) return "☀️";
    if (name.contains("المساء")) return "🌙";
    if (name.contains("النوم")) return "🌃";
    if (name.contains("الصلاة")) return "🕌";
    if (name.contains("أدعية")) return "🙌";
    return "📖";
  }

  @override
  Widget build(BuildContext context) {
    final Color cardColor = getCategoryColor(index);
    return GestureDetector(
      onTap: () => context.push(AppRouter.athkarDetailsScreen, extra: category),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: cardColor.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getCategoryIcon(category.categoryName), style: TextStyle(fontSize: 30.sp)),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.categoryName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.font18MediumBlackColor.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "${category.adhkarList.length} ذكر",
                        style: AppStyles.font14RegularWhiteColor,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16.sp),
              ],
            ),
          ],
        ),
      ),
    );
  }
}