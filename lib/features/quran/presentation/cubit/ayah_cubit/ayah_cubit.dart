import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/features/quran/domain/usecases/get_ayahs_use_case.dart';
import 'package:islamic_app/features/quran/presentation/cubit/ayah_cubit/ayah_state.dart';

class AyahCubit extends Cubit<AyahState> {
  final GetAyahsUseCase getAyahsUseCase;

  AyahCubit({required this.getAyahsUseCase}) : super(AyahInitial());

  Future<void> fetchQuranAyahs(int surahNumber) async {
    emit(AyahLoading());

    final result = await getAyahsUseCase(surahNumber);

    result.fold(
      (failure) => emit(AyahError(message: failure.message)),
      (quran) => emit(AyahSuccess(quranData: quran)),
    );
  }
}