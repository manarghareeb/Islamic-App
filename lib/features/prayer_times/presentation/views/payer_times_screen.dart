import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/widgets/custom_header.dart';
import 'package:islamic_app/features/prayer_times/presentation/cubit/prayer_cubit.dart';
import 'package:islamic_app/features/prayer_times/presentation/cubit/prayer_state.dart';
import 'package:islamic_app/features/prayer_times/presentation/widgets/address_and_date_card.dart';
import 'package:islamic_app/features/prayer_times/presentation/widgets/dymanic_payer_times_card.dart';

class PayerTimesScreen extends StatelessWidget {
  const PayerTimesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBackgroundColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView( 
          child: BlocBuilder<PrayerCubit, PrayerState>(
            builder: (context, state) {
              return Column(
                children: [
                  CustomHeader(
                    isAthkar: false,
                    isHome: false,
                    mediaHeight: 0.5,
                    title: 'مواقيت الصلاة',
                    subTitle: 'أوقات دقيقة حسب موقعك',
                    widget: state is PrayerLoading
                        ? const Center(child: CircularProgressIndicator(color: Colors.white))
                        : state is PrayerSuccess
                            ? AddressAndDateCard(
                                address: "موقعك الحالي",
                                weekday: state.prayerData.hijriWeekday,
                                hijriDate: state.prayerData.fullHijriDate,
                                date: state.prayerData.gregorianDate,
                              )
                            : const SizedBox(),
                  ),

                  if (state is PrayerLoading)
                    Padding(
                      padding: EdgeInsets.only(top: 50.h),
                      child: const Center(child: CircularProgressIndicator()),
                    ),

                  if (state is PrayerSuccess)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(20),
                        itemCount: preparePrayersList(state.prayerData.timings).length,
                        itemBuilder: (context, index) {
                          final prayersList = preparePrayersList(state.prayerData.timings);
                          return DymanicPayerTimesCard(
                            prayer: prayersList[index],
                          );
                        },
                      ),
                    ),

                  if (state is PrayerError)
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50.h),
                        child: Text(state.message),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  List<Prayer> preparePrayersList(Map<String, String> timings) {
    final List<Map<String, dynamic>> prayerConfig = [
      {'name': 'الفجر', 'icon': Icons.wb_twilight},
      {'name': 'الشروق', 'icon': Icons.wb_sunny},
      {'name': 'الظهر', 'icon': Icons.wb_sunny_rounded},
      {'name': 'العصر', 'icon': Icons.wb_cloudy},
      {'name': 'المغرب', 'icon': Icons.wb_twilight},
      {'name': 'العشاء', 'icon': Icons.nightlight_round},
    ];

    return prayerConfig.map((config) {
      final name = config['name'] as String;
      final time = timings[name] ?? "--:--";

      return Prayer(
        name: name,
        time: time,
        status: calculateStatus(name, time),
        icon: config['icon'] as IconData,
      );
    }).toList();
  }

  PrayerStatus calculateStatus(String name, String time) {
    try {
      final now = DateTime.now();
      final prayerTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(time.split(':')[0]),
        int.parse(time.split(':')[1]),
      );

      if (now.isAfter(prayerTime)) return PrayerStatus.past;
      return PrayerStatus.future;
    } catch (e) {
      return PrayerStatus.future;
    }
  }
}

enum PrayerStatus { past, current, future }

class Prayer {
  final String name;
  final String time;
  final PrayerStatus status;
  final IconData icon;

  Prayer({
    required this.name,
    required this.time,
    required this.status,
    required this.icon,
  });
}
