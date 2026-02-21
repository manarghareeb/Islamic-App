import 'package:dartz/dartz.dart';
import 'package:islamic_app/core/error/failures.dart';
import 'package:islamic_app/features/quran/data/data_sources/quran_remote_data_source.dart';
import 'package:islamic_app/features/quran/domain/entities/ayah_entity.dart';
import 'package:islamic_app/features/quran/domain/entities/quran_entity.dart';
import 'package:islamic_app/features/quran/domain/repositories/quran_repository.dart';

class QuranRepositoryImpl implements QuranRepository {
  final QuranRemoteDataSource remoteDataSource;

  QuranRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<QuranEntity>>> getQuranList() async {
    try {
      final remoteData = await remoteDataSource.getQurans();
      return Right(remoteData);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, QuranEntity>> getAyahsList(int quranNumber) async {
    try {
      final remoteData = await remoteDataSource.getAyahs(quranNumber);
      return Right(remoteData);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AyahEntity>> getRandomAyah() async {
    try {
      final result = await remoteDataSource.getRandomAyah();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure("حدث خطأ أثناء جلب الآية"));
    }
  }
}