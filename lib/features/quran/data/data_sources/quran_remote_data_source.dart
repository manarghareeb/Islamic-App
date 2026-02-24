import 'dart:math';

import 'package:islamic_app/core/api/api_consumer.dart';
import 'package:islamic_app/core/api/end_ponits.dart';
import 'package:islamic_app/core/error/error_model.dart';
import 'package:islamic_app/core/error/expections.dart';
import 'package:islamic_app/features/quran/data/models/ayah_model.dart';
import 'package:islamic_app/features/quran/data/models/quran_model.dart';

abstract class QuranRemoteDataSource {
  Future<List<QuranModel>> getQurans();
  Future<QuranModel> getAyahs(int quranNumber);
  Future<AyahModel> getRandomAyah();
}

class QuranRemoteDataSourceImpl implements QuranRemoteDataSource {
  final ApiConsumer apiConsumer;

  QuranRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<QuranModel>> getQurans() async {
    final response = await apiConsumer.get('${EndPoint.quranBaseUrl}${EndPoint.quran}');
    return (response['data'] as List)
        .map((e) => QuranModel.fromJson(e))
        .toList();
  }

  @override
  Future<QuranModel> getAyahs(int quranNumber) async {
    try {
      final response = await apiConsumer.get('${EndPoint.quranBaseUrl}${EndPoint.quran}/$quranNumber');

      if (response['data'] != null) {
        var model = QuranModel.fromJson(response['data']);

        if (model.ayahs != null) {
          final cleanedAyahs = model.ayahs!.map((ayah) {
            return ayah.copyWith(
              text: ayah.text.replaceAll('\n', ' ').trim(),
            );
          }).toList();
          return model.copyWith(ayahs: cleanedAyahs);
        }
        return model;
      } else {
        throw ServerException(
          errModel: ErrorModel(errorMessage: "Data not found", status: 404),
        );
      }
    } on Exception catch (e) {
      throw ServerException(
        errModel: ErrorModel(errorMessage: e.toString(), status: 500),
      );
    }
  }

  @override
  Future<AyahModel> getRandomAyah() async {
    try {
      int randomAyah = Random().nextInt(6236) + 1;
      final response = await apiConsumer.get('${EndPoint.quranBaseUrl}${EndPoint.ayah}/$randomAyah');

      if (response['data'] != null) {
        return AyahModel.fromJson(response['data']);
      } else {
        throw ServerException(
          errModel: ErrorModel(errorMessage: "Ayah not found", status: 404),
        );
      }
    } catch (e) {
      throw ServerException(
        errModel: ErrorModel(errorMessage: e.toString(), status: 500),
      );
    }
  }
}
