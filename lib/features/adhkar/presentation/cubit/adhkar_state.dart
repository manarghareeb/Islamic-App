import '../../domain/entities/adhkar_category_entity.dart';

abstract class AdhkarState {}

class AdhkarInitial extends AdhkarState {}

class AdhkarLoading extends AdhkarState {}

class AdhkarSuccess extends AdhkarState {
  final List<AdhkarCategoryEntity> categories;
  AdhkarSuccess(this.categories);
}

class AdhkarError extends AdhkarState {
  final String message;
  AdhkarError(this.message);
}