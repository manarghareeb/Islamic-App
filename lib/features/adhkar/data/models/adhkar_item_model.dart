import '../../domain/entities/adhkar_item_entity.dart';

class AdhkarItemModel extends AdhkarItemEntity {
  AdhkarItemModel({
    required super.id,
    required super.text,
    required super.count,
  });

  factory AdhkarItemModel.fromJson(Map<String, dynamic> json) {
    return AdhkarItemModel(
      id: json['id'] ?? 0,
      text: json['text'] ?? '',
      count: json['count'] ?? 1,
    );
  }
}