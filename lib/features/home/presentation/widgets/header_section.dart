import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/features/home/presentation/widgets/prayer_times_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/core/widgets/custom_header.dart';
import 'package:islamic_app/features/prayer_times/presentation/cubit/prayer_cubit.dart';
import 'package:islamic_app/features/prayer_times/presentation/cubit/prayer_state.dart';

class HomeHeader extends StatefulWidget {
  final bool isHome;
  final bool isAthkar;
  final double mediaHeight;
  final String title;
  final String subTitle;

  const HomeHeader({
    super.key,
    required this.isHome,
    required this.isAthkar,
    required this.mediaHeight,
    required this.title,
    required this.subTitle,
  });

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (mounted) setState(() {}); 
    });
  }

  @override
  void dispose() {
    timer?.cancel(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CustomHeader(
        isHome: widget.isHome,
        isAthkar: widget.isAthkar,
        mediaHeight: 0.5,
        title: widget.title,
        subTitle: widget.subTitle,
        widget: Builder(
          builder: (context) {
            final state = context.watch<PrayerCubit>().state;

            if (state is PrayerLoading) {
              return SizedBox(
                height: 200.h,
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              );
            } else if (state is PrayerError) {
              return SizedBox(
                height: 200.h,
                child: const Center(
                  child: Text(
                    'حدث خطأ في تحميل مواقيت الصلاة',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            } else if (state is PrayerSuccess) {
              return PrayerTimesCard(prayerData: state.prayerData);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}