import 'package:dio/dio.dart';
import 'package:islamic_app/core/api/api_consumer.dart';
import 'package:islamic_app/core/api/end_ponits.dart';
import 'package:islamic_app/features/prayer_times/data/models/payer_times_model.dart';

abstract class PrayerRemoteDataSource {
  Future<PrayerTimesModel> getPrayerTimes(double lat, double lon);
}

class PrayerRemoteDataSourceImpl implements PrayerRemoteDataSource {
  final ApiConsumer apiConsumer;
  PrayerRemoteDataSourceImpl({required this.apiConsumer});

  @override
  @override
Future<PrayerTimesModel> getPrayerTimes(double lat, double lon) async {
  try {
    final response = await apiConsumer.get(
      '${EndPoint.prayerBaseUrl}${EndPoint.prayerTimes}',
      queryParameters: {'latitude': lat, 'longitude': lon, 'method': 5},
    );
    print("✅ Prayer API Response: $response");     
    print("🔹 Requesting prayer times for ($lat, $lon)");
    return PrayerTimesModel.fromJson(response); 
  } on DioException catch (e) {
    print("❌ Dio error: ${e.response?.data ?? e.message}");
    throw Exception(e.message ?? "خطأ في الاتصال بالسيرفر");
  } catch (e) {
    print("🚨 RemoteDataSource Error: $e");
    rethrow;
  }
}
}
