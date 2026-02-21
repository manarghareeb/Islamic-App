import 'package:islamic_app/features/quran/domain/entities/ayah_entity.dart';

class QuranEntity {
  final int number;
  final String name;
  final String englishName;
  final int numberOfAyahs;
  final String revelationType;
  final List<AyahEntity>? ayahs;

  QuranEntity({
    required this.number,
    required this.name,
    required this.numberOfAyahs,
    required this.revelationType,
    required this.englishName,
    this.ayahs,
  });
}
