import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/features/quran/domain/entities/quran_entity.dart';
import 'package:islamic_app/features/quran/domain/usecases/get_quran_usecase.dart';
import 'package:islamic_app/features/quran/presentation/cubit/quran_cubit/quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  final GetQuransUseCase getQuransUseCase;
  QuranCubit({required this.getQuransUseCase}) : super(QuranInitial());

  List<QuranEntity> allQurans = [];

  Future<void> fetchQurans() async {
    emit(QuranLoading());
    final result = await getQuransUseCase();
    result.fold((failure) => emit(QuranError(failure.message)), (qurans) {
      allQurans = qurans;
      emit(QuranSuccess(qurans: qurans));
    });
  }

  void searchQuran(String query) {
  if (query.isEmpty) {
    emit(QuranSuccess(qurans: allQurans));
  } else {
    String normalize(String text) {
      return text
          .replaceAll(RegExp(r'[\u064B-\u065F]'), '')
          .replaceAll('أ', 'ا')
          .replaceAll('إ', 'ا')
          .replaceAll('آ', 'ا')
          .replaceAll('ة', 'ه')
          .trim();
    }

    final filteredList = allQurans.where((quran) {
      final normalizedName = normalize(quran.name);
      final normalizedQuery = normalize(query);
      
      return normalizedName.contains(normalizedQuery) ||
             quran.englishName.toLowerCase().contains(query.toLowerCase());
    }).toList();
    
    emit(QuranSuccess(qurans: filteredList));
  }
}
}
