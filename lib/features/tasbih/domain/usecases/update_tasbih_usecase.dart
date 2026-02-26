import 'package:dartz/dartz.dart';
import 'package:islamic_app/core/error/failures.dart';
import '../entities/tasbih_entity.dart';
import '../repositories/tasbih_repository.dart';

class UpdateTasbihUseCase {
  final TasbihRepository repository;

  UpdateTasbihUseCase({required this.repository});

  Future<Either<Failure, void>> call(TasbihEntity tasbih) async {
    return await repository.updateTasbih(tasbih);
  }
}