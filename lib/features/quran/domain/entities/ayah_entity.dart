class AyahEntity {
  final int number;
  final String text;
  final int numberInSurah;
  final String surahName;

  AyahEntity({
    required this.number,
    required this.text,
    required this.numberInSurah,
    required this.surahName,
  });
  AyahEntity copyWith({
    int? number,
    String? text,
    int? numberInSurah,
    String? surahName,
  }) {
    return AyahEntity(
      number: number ?? this.number,
      text: text ?? this.text,
      numberInSurah: numberInSurah ?? this.numberInSurah,
      surahName: surahName ?? this.surahName,
    );
  }
}
