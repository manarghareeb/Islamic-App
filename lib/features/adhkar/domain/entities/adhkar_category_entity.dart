import 'adhkar_item_entity.dart';

class AdhkarCategoryEntity {
  final int id;
  final String categoryName;
  final List<AdhkarItemEntity> adhkarList;

  AdhkarCategoryEntity({
    required this.id,
    required this.categoryName,
    required this.adhkarList,
  });
}