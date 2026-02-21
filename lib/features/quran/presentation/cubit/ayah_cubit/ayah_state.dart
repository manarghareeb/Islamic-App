import 'package:islamic_app/features/quran/domain/entities/quran_entity.dart';

abstract class AyahState {}

class AyahInitial extends AyahState {}

class AyahLoading extends AyahState {}

class AyahSuccess extends AyahState {
  final QuranEntity quranData; 
  AyahSuccess({required this.quranData});
}

class AyahError extends AyahState {
  final String message;
  AyahError({required this.message});
}