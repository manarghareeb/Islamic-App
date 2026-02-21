import 'package:islamic_app/features/quran/domain/entities/ayah_entity.dart';

class AyahModel extends AyahEntity {
  AyahModel({
    required super.number,
    required super.text,
    required super.numberInSurah,
    required super.surahName,
  });

  factory AyahModel.fromJson(Map<String, dynamic> json) {
    return AyahModel(
      number: json['number'],
      text: json['text'],
      numberInSurah: json['numberInSurah'],
      //surahName: json['surah']['name'],
      surahName: json['surah'] != null ? json['surah']['name'] : '',
    );
  }
}