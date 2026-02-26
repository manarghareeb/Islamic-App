import 'package:dartz/dartz.dart';
import 'package:islamic_app/core/error/failures.dart';
import 'package:islamic_app/features/tasbih/domain/entities/tasbih_entity.dart';
import 'package:islamic_app/features/tasbih/domain/repositories/tasbih_repository.dart';

class GetAllTasbihsUseCase {
  final TasbihRepository repository;

  GetAllTasbihsUseCase({required this.repository});

  Future<Either<Failure, List<TasbihEntity>>> call () async {
    return await repository.getAllTasbih();
  }
}