class TasbihEntity {
  final String phrase;
  final int currentCount;
  final int totalRounds;

  TasbihEntity({
    required this.phrase,
    required this.currentCount,
    required this.totalRounds,
  });

  TasbihEntity copyWith({
    String? phrase,
    int? currentCount,
    int? totalRounds,
  }) {
    return TasbihEntity(
      phrase: phrase ?? this.phrase,
      currentCount: currentCount ?? this.currentCount,
      totalRounds: totalRounds ?? this.totalRounds,
    );
  }
}