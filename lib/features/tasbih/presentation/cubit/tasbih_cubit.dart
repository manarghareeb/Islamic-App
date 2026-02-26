import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/features/tasbih/domain/entities/tasbih_entity.dart';
import 'package:islamic_app/features/tasbih/domain/usecases/add_tasbih_usecase.dart';
import 'package:islamic_app/features/tasbih/domain/usecases/get_tasbih_usecase.dart';
import 'package:islamic_app/features/tasbih/domain/usecases/update_tasbih_usecase.dart';
import 'package:islamic_app/features/tasbih/presentation/cubit/tasbih_state.dart';

class TasbihCubit extends Cubit<TasbihState> {
  final GetAllTasbihsUseCase getAllTasbihs;
  final AddTasbihUseCase saveTasbih;
  final UpdateTasbihUseCase updateTasbih;

  TasbihCubit({
    required this.getAllTasbihs,
    required this.saveTasbih,
    required this.updateTasbih,
  }) : super(TasbihInitial());

  List<TasbihEntity> tasbihs = [];

  Future<void> loadTasbihs() async {
  emit(TasbihLoading());

  final result = await getAllTasbihs();

  await result.fold(
    (failure) async {
      emit(TasbihError(failure.message));
    },
    (data) async {
      if (data.isEmpty) {
        final defaultPhrases = [
          'سبحان الله',
          'الحمد لله',
          'الله أكبر',
          'لا إله إلا الله',
        ];

        for (final phrase in defaultPhrases) {
          await saveTasbih(
            TasbihEntity(phrase: phrase, currentCount: 0, totalRounds: 0),
          );
        }

        final refreshed = await getAllTasbihs();
        refreshed.fold(
          (failure) => emit(TasbihError(failure.message)),
          (updatedData) {
            tasbihs = updatedData;
            emit(TasbihLoaded(tasbihs));
          },
        );
      } else {
        tasbihs = data;
        emit(TasbihLoaded(tasbihs));
      }
    },
  );
}
  Future<void> addTasbih(String phrase) async {
    final newTasbih = TasbihEntity(
      phrase: phrase,
      currentCount: 0,
      totalRounds: 0,
    );
    final result = await saveTasbih(newTasbih);
    result.fold(
      (failure) => emit(TasbihError(failure.message)),
      (_) async {
        tasbihs.add(newTasbih);
        emit(TasbihLoaded(tasbihs));
      },
    );
  }

  Future<void> incrementTasbih(TasbihEntity tasbih, int target) async {
    final index = tasbihs.indexWhere((t) => t.phrase == tasbih.phrase);
    if (index == -1) return;

    int newCount = tasbihs[index].currentCount + 1;
    int newRounds = tasbihs[index].totalRounds;

    if (newCount >= target) {
      newCount = 0;
      newRounds += 1;
    }

    final updatedTasbih = tasbihs[index].copyWith(
      currentCount: newCount,
      totalRounds: newRounds,
    );

    final result = await updateTasbih(updatedTasbih);
    result.fold(
      (failure) => emit(TasbihError(failure.message)),
      (_) {
        tasbihs[index] = updatedTasbih;
        emit(TasbihLoaded(tasbihs));
      },
    );
  }

  Future<void> resetTasbih(TasbihEntity tasbih) async {
    final index = tasbihs.indexWhere((t) => t.phrase == tasbih.phrase);
    if (index == -1) return;

    final updatedTasbih = tasbihs[index].copyWith(currentCount: 0, totalRounds: 0);
    final result = await updateTasbih(updatedTasbih);

    result.fold(
      (failure) => emit(TasbihError(failure.message)),
      (_) {
        tasbihs[index] = updatedTasbih;
        emit(TasbihLoaded(tasbihs));
      },
    );
  }
}