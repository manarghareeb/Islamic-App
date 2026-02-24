import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/features/prayer_times/domain/usecases/get_prayer_times_usecase.dart';
import 'package:islamic_app/features/prayer_times/presentation/cubit/prayer_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  final GetPrayerTimesUseCase getPrayerTimesUseCase;
  
  PrayerCubit({required this.getPrayerTimesUseCase}) : super(PrayerInitial());

  Future<void> fetchPrayerTimes() async {
    print("🟨 PrayerCubit: fetchPrayerTimes() called");
    emit(PrayerLoading());
    final result = await getPrayerTimesUseCase();
    result.fold(
      (failure)  {
        print("❌ Error fetching prayer times: ${failure.message}");
        emit(PrayerError(failure.message));
      },
      (prayerData) {
        print("✅ Emitting Success State");
        emit(PrayerSuccess(prayerData)); 
      },
    );
  }
}