import '../../domain/entities/adhkar_category_entity.dart';
import 'adhkar_item_model.dart';

class AdhkarCategoryModel extends AdhkarCategoryEntity {
  AdhkarCategoryModel({
    required super.id,
    required super.categoryName,
    required super.adhkarList,
  });

  factory AdhkarCategoryModel.fromJson(Map<String, dynamic> json) {
    return AdhkarCategoryModel(
      id: json['id'] ?? 0,
      categoryName: json['category'] ?? '',
      adhkarList: (json['array'] as List? ?? [])
          .map((item) => AdhkarItemModel.fromJson(item))
          .toList(),
    );
  }
}