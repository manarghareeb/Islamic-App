import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/features/quran/presentation/cubit/random_ayah_cubit/random_ayah_state.dart';
import '../../../../quran/domain/usecases/get_random_ayah_usecase.dart';

class RandomAyahCubit extends Cubit<RandomAyahState> {
  final GetRandomAyahUseCase getRandomAyahUseCase;

  RandomAyahCubit({required this.getRandomAyahUseCase}) : super(RandomAyahInitial());

  Future<void> fetchRandomAyah() async {
    emit(RandomAyahLoading());

    final result = await getRandomAyahUseCase();

    result.fold(
      (failure) => emit(RandomAyahError(message: failure.message)),
      (ayah) => emit(RandomAyahSuccess(ayah: ayah)),
    );
  }
}