import 'package:islamic_app/features/quran/data/models/ayah_model.dart';
import 'package:islamic_app/features/quran/domain/entities/quran_entity.dart';

class QuranModel extends QuranEntity {
  QuranModel({
    required super.number, 
    required super.name, 
    required super.englishName,
    required super.numberOfAyahs, 
    required super.revelationType,
    super.ayahs,
  });

  factory QuranModel.fromJson(Map<String, dynamic> json) {
    return QuranModel(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      numberOfAyahs: json['numberOfAyahs'],
      revelationType: json['revelationType'],
      ayahs: json['ayahs'] != null
          ? (json['ayahs'] as List).map((e) => AyahModel.fromJson(e)).toList()
          : null,
    );
  }
}