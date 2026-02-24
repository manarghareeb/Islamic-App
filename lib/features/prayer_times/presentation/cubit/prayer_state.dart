import 'package:islamic_app/features/prayer_times/domain/entities/prayer_time_entity.dart';

abstract class PrayerState {}

class PrayerInitial extends PrayerState {}
class PrayerLoading extends PrayerState {}
class PrayerSuccess extends PrayerState {
  final PrayerTimesEntity prayerData;
  PrayerSuccess(this.prayerData);
}
class PrayerError extends PrayerState {
  final String message;
  PrayerError(this.message);
}