import '../../../../quran/domain/entities/ayah_entity.dart';

abstract class RandomAyahState {}

class RandomAyahInitial extends RandomAyahState {}
class RandomAyahLoading extends RandomAyahState {}
class RandomAyahSuccess extends RandomAyahState {
  final AyahEntity ayah;
  RandomAyahSuccess({required this.ayah});
}
class RandomAyahError extends RandomAyahState {
  final String message;
  RandomAyahError({required this.message});
}