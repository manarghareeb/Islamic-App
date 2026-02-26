import 'package:dartz/dartz.dart';
import 'package:islamic_app/core/error/failures.dart';
import 'package:islamic_app/features/tasbih/data/data_sources/tasbih_local_data_source.dart';

import '../../domain/entities/tasbih_entity.dart';
import '../../domain/repositories/tasbih_repository.dart';
import '../models/tasbih_model.dart';

class TasbihRepositoryImpl implements TasbihRepository {
  final TasbihLocalDataSource localDataSource;

  TasbihRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<TasbihEntity>>> getAllTasbih() async {
    try {
      final models = await localDataSource.getAllTasbih();
      return Right(models.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure("Failed to load Tasbihs: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, void>> addTasbih(TasbihEntity tasbih) async {
    try {
      await localDataSource.addTasbih(TasbihModel.fromEntity(tasbih));
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure("Failed to save Tasbih: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, void>> updateTasbih(TasbihEntity tasbih) async {
    try {
      final models = await localDataSource.getAllTasbih();
      final model = models.firstWhere((m) => m.phrase == tasbih.phrase);
      model.currentCount = tasbih.currentCount;
      model.totalRounds = tasbih.totalRounds;
      await localDataSource.updateTasbih(model);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure("Failed to update Tasbih: ${e.toString()}"));
    }
  }
}
