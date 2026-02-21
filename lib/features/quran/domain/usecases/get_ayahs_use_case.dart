import 'package:dartz/dartz.dart';
import 'package:islamic_app/core/error/failures.dart';
import 'package:islamic_app/features/quran/domain/entities/quran_entity.dart';
import 'package:islamic_app/features/quran/domain/repositories/quran_repository.dart';

class GetAyahsUseCase {
  final QuranRepository repository;
  GetAyahsUseCase({required this.repository});

  Future<Either<Failure, QuranEntity>> call(int quranNumber) {
    return repository.getAyahsList(quranNumber);
  }
}