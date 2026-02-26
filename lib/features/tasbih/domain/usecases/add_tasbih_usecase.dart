import 'package:dartz/dartz.dart';
import 'package:islamic_app/core/error/failures.dart';
import '../entities/tasbih_entity.dart';
import '../repositories/tasbih_repository.dart';

class AddTasbihUseCase {
  final TasbihRepository repository;

  AddTasbihUseCase({required this.repository});

  Future<Either<Failure, void>> call(TasbihEntity tasbih) async {
    return await repository.addTasbih(tasbih);
  }
}