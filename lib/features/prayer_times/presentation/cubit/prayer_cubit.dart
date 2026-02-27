import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/core/services/local_notifications_service.dart';
import 'package:islamic_app/features/prayer_times/domain/usecases/get_prayer_times_usecase.dart';
import 'package:islamic_app/features/prayer_times/presentation/cubit/prayer_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrayerCubit extends Cubit<PrayerState> {
  final GetPrayerTimesUseCase getPrayerTimesUseCase;

  PrayerCubit({required this.getPrayerTimesUseCase}) : super(PrayerInitial()){
    _loadNotificationSettings();
  }
  dynamic lastFetchedPrayerData;
  Map<String, bool> prayerNotificationsStatus = {
    'الفجر': true,
    'الشروق': false,
    'الظهر': true,
    'العصر': true,
    'المغرب': true,
    'العشاء': true,
  };

  Future<void> _loadNotificationSettings() async {
    final prefs = await SharedPreferences.getInstance();
    for (var key in prayerNotificationsStatus.keys) {
      bool defaultValue = (key == 'الشروق') ? false : true;
      prayerNotificationsStatus[key] = prefs.getBool(key) ?? defaultValue;
    }
    log("✅ Loaded Status from Storage: $prayerNotificationsStatus");
    
    if (lastFetchedPrayerData != null) {
      emit(PrayerSuccess(lastFetchedPrayerData));
    }
  }

  Future<void> fetchPrayerTimes() async {
    emit(PrayerLoading());
    log(
      'Fetching prayer times...${lastFetchedPrayerData != null ? ' Using cached data' : ''}',
    );
    final result = await getPrayerTimesUseCase();
    result.fold(
      (failure) {
        emit(PrayerError(failure.message));
        log('Failed to fetch prayer times: ${failure.message}');
      },
      (prayerData) async {
        lastFetchedPrayerData = prayerData;
        await _scheduleAllPrayers(prayerData);
        log('Prayer times fetched successfully: $prayerData');
        emit(PrayerSuccess(prayerData));
      },
    );
  }

  Future<void> togglePrayerNotification(
    String prayerName,
    bool isEnabled,
  ) async {
    prayerNotificationsStatus[prayerName] = isEnabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(prayerName, isEnabled);
    log("💾 Saved: $prayerName -> $isEnabled");
    
    if (isEnabled) {
      if (lastFetchedPrayerData != null) {
        await _scheduleAllPrayers(lastFetchedPrayerData);
      }
    } else {
      await LocalNotificationsService.cancelNotification(prayerName.hashCode);
    }
    if (lastFetchedPrayerData != null) {
      emit(PrayerSuccess(lastFetchedPrayerData));
    }
  }

  Future<void> _scheduleAllPrayers(dynamic prayerData) async {
    if (prayerData == null || prayerData.timings == null) return;

    List<String> prayerKeys = ['الفجر', 'الشروق', 'الظهر', 'العصر', 'المغرب', 'العشاء'];
    Map<String, String> filteredTimings = {};

    for (var key in prayerKeys) {
      bool isEnabled = prayerNotificationsStatus[key] ?? (key == 'الشروق' ? false : true);

      if (isEnabled) {
        String? time = prayerData.timings[key];
        if (time != null && time != "--") {
          filteredTimings[key] = time;
        }
      }
    }
    log('Filtered Timings to schedule: $filteredTimings');

    if (filteredTimings.isNotEmpty) {
      await LocalNotificationsService.schedulePrayerNotifications(
        filteredTimings,
      );
    } else {
      log(
        '⚠️ No timings were filtered. Timings in Model: ${prayerData.timings}',
      );
    }
  }
}
