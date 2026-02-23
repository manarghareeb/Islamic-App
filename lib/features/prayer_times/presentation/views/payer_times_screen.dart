import 'package:flutter/material.dart';
import 'package:islamic_app/core/theme/colors.dart';
import 'package:islamic_app/core/widgets/custom_header.dart';
import 'package:islamic_app/features/prayer_times/presentation/widgets/address_and_date_card.dart';
import 'package:islamic_app/features/prayer_times/presentation/widgets/dymanic_payer_times_card.dart';

class PayerTimesScreen extends StatelessWidget {
  const PayerTimesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Prayer> prayers = [
      Prayer(
        name: "الفجر",
        time: "5:15",
        status: PrayerStatus.past,
        icon: Icons.wb_twilight,
      ),
      Prayer(
        name: "الشروق",
        time: "6:45",
        status: PrayerStatus.past,
        icon: Icons.wb_sunny,
      ),
      Prayer(
        name: "الظهر",
        time: "12:30",
        status: PrayerStatus.current,
        icon: Icons.wb_sunny_rounded,
      ),
      Prayer(
        name: "العصر",
        time: "3:45",
        status: PrayerStatus.future,
        icon: Icons.wb_cloudy,
      ),
      Prayer(
        name: "المغرب",
        time: "6:15",
        status: PrayerStatus.future,
        icon: Icons.wb_twilight,
      ),
      Prayer(
        name: "العشاء",
        time: "7:45",
        status: PrayerStatus.future,
        icon: Icons.nightlight_round,
      ),
    ];
    return Scaffold(
      backgroundColor: AppColors.whiteBackgroundColor,
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              CustomHeader(
                isAthkar: false,
                isHome: false,
                mediaHeight: 0.55,
                title: 'مواقيت الصلاة',
                subTitle: 'أوقات دقيقة حسب موقعك',
                widget: const AddressAndDateCard(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  itemCount: prayers.length,
                  itemBuilder: (context, index) {
                    return DymanicPayerTimesCard(prayer: prayers[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
