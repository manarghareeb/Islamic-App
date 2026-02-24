import 'package:dartz/dartz.dart';
import 'package:islamic_app/core/error/failures.dart';
import '../../domain/entities/adhkar_category_entity.dart';
import '../../domain/repositories/adhkar_repository.dart';
import '../data_sources/adhkar_local_data_source.dart';

class AdhkarRepositoryImpl implements AdhkarRepository {
  final AdhkarLocalDataSource localDataSource;

  AdhkarRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<AdhkarCategoryEntity>>> getAdhkar() async {
    try {
      final remoteAdhkar = await localDataSource.getAllAdhkar();
      return Right(remoteAdhkar);
    } catch (e) {
      return Left(ServerFailure(e.toString())); 
    }
  }
}