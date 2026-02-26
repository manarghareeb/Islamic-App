import 'package:islamic_app/features/tasbih/domain/entities/tasbih_entity.dart';

abstract class TasbihState {}

class TasbihInitial extends TasbihState {}

class TasbihLoading extends TasbihState {}

class TasbihLoaded extends TasbihState {
  final List<TasbihEntity> tasbihs;
  TasbihLoaded(this.tasbihs);
}

class TasbihError extends TasbihState {
  final String message;
  TasbihError(this.message);
}