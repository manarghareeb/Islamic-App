import 'package:dartz/dartz.dart';
import 'package:islamic_app/core/error/failures.dart';

import '../entities/tasbih_entity.dart';

abstract class TasbihRepository {
  Future<Either<Failure, List<TasbihEntity>>> getAllTasbih();
  Future<Either<Failure, void>> addTasbih(TasbihEntity tasbih);
  Future<Either<Failure, void>> updateTasbih(TasbihEntity tasbih);
}
