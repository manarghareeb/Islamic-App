import 'package:hive/hive.dart';
import '../../domain/entities/tasbih_entity.dart';

part 'tasbih_model.g.dart';

@HiveType(typeId: 1)
class TasbihModel extends HiveObject {
  @HiveField(0)
  String phrase;

  @HiveField(1)
  int currentCount;

  @HiveField(2)
  int totalRounds;

  TasbihModel({
    required this.phrase,
    required this.currentCount,
    required this.totalRounds,
  });

  factory TasbihModel.fromEntity(TasbihEntity entity) {
    return TasbihModel(
      phrase: entity.phrase,
      currentCount: entity.currentCount,
      totalRounds: entity.totalRounds,
    );
  }

  TasbihEntity toEntity() {
    return TasbihEntity(
      phrase: phrase,
      currentCount: currentCount,
      totalRounds: totalRounds,
    );
  }
}