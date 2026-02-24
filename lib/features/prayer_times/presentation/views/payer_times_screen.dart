import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/widgets/custom_header.dart';
import 'package:islamic_app/features/prayer_times/domain/entities/prayer_time_entity.dart';
import 'package:islamic_app/features/prayer_times/presentation/cubit/prayer_cubit.dart';
import 'package:islamic_app/features/prayer_times/presentation/cubit/prayer_state.dart';
import 'package:islamic_app/features/prayer_times/presentation/widgets/address_and_date_card.dart';
import 'package:islamic_app/features/prayer_times/presentation/widgets/dymanic_payer_times_card.dart';

class PayerTimesScreen extends StatelessWidget {
  const PayerTimesScreen({super.key, required this.prayerTimes});
  final PrayerTimesEntity prayerTimes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBackgroundColor,
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: BlocBuilder<PrayerCubit, PrayerState>(
            builder: (context, state) {
              if (state is PrayerLoading) {
                print("⏳ Loading prayer times...");
                return const Center(child: CircularProgressIndicator());
              }
              if (state is PrayerSuccess) {
                print("✅ Prayer times loaded successfully");
                final data = state.prayerData;
                final prayersList = preparePrayersList(data.timings);

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomHeader(
                        isAthkar: false,
                        isHome: false,
                        mediaHeight: 0.55,
                        title: 'مواقيت الصلاة',
                        subTitle: 'أوقات دقيقة حسب موقعك',
                        widget: AddressAndDateCard(
                          address: "موقعك الحالي",
                          weekday: data.hijriWeekday,
                          hijriDate: data.fullHijriDate,
                          date: data.gregorianDate,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(20),
                          itemCount: prayersList.length,
                          itemBuilder: (context, index) {
                            return DymanicPayerTimesCard(
                              prayer: prayersList[index],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (state is PrayerError) {
                print("❌ PrayerError State: ${state.message}");
                return Center(child: Text(state.message));
              } else {
                print("⚠️ Unexpected State: ${state.runtimeType}");
                return const SizedBox();
              }
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
