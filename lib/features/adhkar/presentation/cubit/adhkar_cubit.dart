import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/features/adhkar/domain/usecases/get_adhkar_use_case.dart';
import 'adhkar_state.dart';

class AdhkarCubit extends Cubit<AdhkarState> {
  final GetAdhkarUseCase getAdhkarUseCase;

  AdhkarCubit({required this.getAdhkarUseCase}) : super(AdhkarInitial());

  Future<void> fetchAllAdhkar() async {
    emit(AdhkarLoading());
    final result = await getAdhkarUseCase();
    result.fold(
      (failure) => emit(AdhkarError(failure.message)),
      (categories) => emit(AdhkarSuccess(categories)),
    );
  }
}