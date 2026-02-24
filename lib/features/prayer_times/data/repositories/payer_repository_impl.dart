import 'package:dartz/dartz.dart';
import 'package:islamic_app/core/error/failures.dart';
import 'package:islamic_app/features/prayer_times/data/data_sources/prayer_remote_data_source.dart';
import 'package:islamic_app/features/prayer_times/domain/entities/prayer_time_entity.dart';
import 'package:islamic_app/features/prayer_times/domain/repositories/payer_repository.dart';

class PrayerRepositoryImpl implements PrayerRepository {
  final PrayerRemoteDataSource remoteDataSource;

  PrayerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PrayerTimesEntity>> getPrayerTimes(double lat, double lon) async {
    try {
      final remoteData = await remoteDataSource.getPrayerTimes(lat, lon);
      return Right(remoteData); 
    } catch (e) {
      return Left(ServerFailure("فشل في جلب البيانات، تأكد من الاتصال بالإنترنت")); 
    }
  }
}