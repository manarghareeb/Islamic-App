import 'package:dartz/dartz.dart';
import 'package:islamic_app/core/error/failures.dart';
import 'package:islamic_app/features/quran/domain/entities/ayah_entity.dart';
import 'package:islamic_app/features/quran/domain/entities/quran_entity.dart';

abstract class QuranRepository {
  Future<Either<Failure, List<QuranEntity>>> getQuranList();
  Future<Either<Failure, QuranEntity>> getAyahsList(int quranNumber);
  Future<Either<Failure, AyahEntity>> getRandomAyah();
}
