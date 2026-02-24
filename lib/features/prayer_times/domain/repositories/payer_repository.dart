import 'package:dartz/dartz.dart';
import 'package:islamic_app/core/error/failures.dart';
import 'package:islamic_app/features/prayer_times/domain/entities/prayer_time_entity.dart';

abstract class PrayerRepository {
  Future<Either<Failure, PrayerTimesEntity>> getPrayerTimes(double lat, double lon);
}