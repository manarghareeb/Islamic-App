import 'package:dartz/dartz.dart';
import 'package:islamic_app/core/error/failures.dart';
import '../entities/adhkar_category_entity.dart';

abstract class AdhkarRepository {
  Future<Either<Failure, List<AdhkarCategoryEntity>>> getAdhkar();
}