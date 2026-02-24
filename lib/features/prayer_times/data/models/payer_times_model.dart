import 'package:islamic_app/features/prayer_times/domain/entities/prayer_time_entity.dart';

class PrayerTimesModel extends PrayerTimesEntity {
  PrayerTimesModel({
    required super.timings,
    required super.hijriDay,
    required super.hijriMonth,
    required super.hijriYear,
    required super.hijriWeekday,
    required super.gregorianDate,
  });
  
  factory PrayerTimesModel.fromJson(Map<String, dynamic> json) {
  final data = json['data'] ?? {};
  final hijri = data['date']?['hijri'] ?? {};
  final timings = data['timings'] ?? {};

  return PrayerTimesModel(
    timings: {
      "الفجر": timings['Fajr'] ?? "--",
      "الشروق": timings['Sunrise'] ?? "--",
      "الظهر": timings['Dhuhr'] ?? "--",
      "العصر": timings['Asr'] ?? "--",
      "المغرب": timings['Maghrib'] ?? "--",
      "العشاء": timings['Isha'] ?? "--",
    },
    hijriDay: hijri['day'] ?? "--",
    hijriMonth: hijri['month']?['ar'] ?? "--",
    hijriYear: hijri['year'] ?? "--",
    hijriWeekday: hijri['weekday']?['ar'] ?? "--",
    gregorianDate: data['date']?['gregorian']?['date'] ?? "--",
  );
}
}