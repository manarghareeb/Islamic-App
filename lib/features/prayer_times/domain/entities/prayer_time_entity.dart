class PrayerTimesEntity {
  final Map<String, String> timings;
  final String hijriDay;
  final String hijriMonth;
  final String hijriYear;
  final String hijriWeekday;
  final String gregorianDate;

  PrayerTimesEntity({
    required this.timings,
    required this.hijriDay,
    required this.hijriMonth,
    required this.hijriYear,
    required this.hijriWeekday,
    required this.gregorianDate,
  });

  String get fullHijriDate => "$hijriDay $hijriMonth $hijriYear هـ";
}