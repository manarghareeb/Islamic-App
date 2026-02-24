import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:islamic_app/core/error/failures.dart';
import 'package:islamic_app/features/prayer_times/domain/entities/prayer_time_entity.dart';
import 'package:islamic_app/features/prayer_times/domain/repositories/payer_repository.dart';

class GetPrayerTimesUseCase {
  final PrayerRepository repository;

  GetPrayerTimesUseCase({required this.repository});

  Future<Either<Failure, PrayerTimesEntity>> call() async {
    print("🟨 UseCase called");

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      print("📍 serviceEnabled = $serviceEnabled");

      if (!serviceEnabled) {
        print("⚠️ GPS is disabled!");
        return Left(ServerFailure("خدمة الموقع مغلقة، يرجى تفعيل الـ GPS"));
      }

      LocationPermission permission = await Geolocator.checkPermission();
      print("📍 permission = $permission");

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        print("📍 permission after request = $permission");
        if (permission == LocationPermission.denied) {
          print("⚠️ Permission denied");
          return Left(ServerFailure("تم رفض إذن الوصول للموقع"));
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print("⚠️ Permission denied forever");
        return Left(ServerFailure("إذن الموقع مرفوض نهائيًا"));
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      print("📍 Got position: ${position.latitude}, ${position.longitude}");

      return await repository.getPrayerTimes(
        position.latitude,
        position.longitude,
      );
    } catch (e) {
      print("❌ UseCase Error: $e");
      return Left(ServerFailure("حدث خطأ غير متوقع أثناء تحديد موقعك"));
    }
  }
}
