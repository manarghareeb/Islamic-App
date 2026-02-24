import 'package:dartz/dartz.dart';
import 'package:islamic_app/core/error/failures.dart';
import '../entities/adhkar_category_entity.dart';
import '../repositories/adhkar_repository.dart';

class GetAdhkarUseCase {
  final AdhkarRepository repository;

  GetAdhkarUseCase({required this.repository});

  Future<Either<Failure, List<AdhkarCategoryEntity>>> call() async {
    return await repository.getAdhkar();
  }
}