import 'package:dartz/dartz.dart';
import 'package:islamic_app/core/error/failures.dart';
import 'package:islamic_app/features/quran/domain/entities/quran_entity.dart';
import 'package:islamic_app/features/quran/domain/repositories/quran_repository.dart';

class GetQuransUseCase {
  final QuranRepository repository;
  GetQuransUseCase({required this.repository});

  Future<Either<Failure, List<QuranEntity>>> call() async {
    return await repository.getQuranList();
  }
}