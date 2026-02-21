import 'package:dartz/dartz.dart';
import 'package:islamic_app/core/error/failures.dart';
import 'package:islamic_app/features/quran/domain/entities/ayah_entity.dart';
import 'package:islamic_app/features/quran/domain/repositories/quran_repository.dart';

class GetRandomAyahUseCase {
  final QuranRepository repository;
  GetRandomAyahUseCase({required this.repository});

  Future<Either<Failure, AyahEntity>> call() {
    return repository.getRandomAyah();
  }
}