import 'package:islamic_app/features/quran/domain/entities/quran_entity.dart';

abstract class QuranState {}

class QuranInitial extends QuranState {}
class QuranLoading extends QuranState {}
class QuranSuccess extends QuranState {
  final List<QuranEntity> qurans;
  QuranSuccess({required this.qurans});
}
class QuranError extends QuranState {
  final String message;
  QuranError(this.message);
}