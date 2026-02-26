import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:islamic_app/core/api/api_consumer.dart';
import 'package:islamic_app/core/api/dio_consumer.dart';
import 'package:islamic_app/features/adhkar/data/data_sources/adhkar_local_data_source.dart';
import 'package:islamic_app/features/adhkar/data/repositories/adhkar_repository_impl.dart';
import 'package:islamic_app/features/adhkar/domain/repositories/adhkar_repository.dart';
import 'package:islamic_app/features/adhkar/domain/usecases/get_adhkar_use_case.dart';
import 'package:islamic_app/features/adhkar/presentation/cubit/adhkar_cubit.dart';
import 'package:islamic_app/features/prayer_times/data/data_sources/prayer_remote_data_source.dart';
import 'package:islamic_app/features/prayer_times/data/repositories/payer_repository_impl.dart';
import 'package:islamic_app/features/prayer_times/domain/repositories/payer_repository.dart';
import 'package:islamic_app/features/prayer_times/domain/usecases/get_prayer_times_usecase.dart';
import 'package:islamic_app/features/prayer_times/presentation/cubit/prayer_cubit.dart';
import 'package:islamic_app/features/quran/data/data_sources/quran_remote_data_source.dart';
import 'package:islamic_app/features/quran/data/repositories/quran_repository_impl.dart';
import 'package:islamic_app/features/quran/domain/repositories/quran_repository.dart';
import 'package:islamic_app/features/quran/domain/usecases/get_ayahs_use_case.dart';
import 'package:islamic_app/features/quran/domain/usecases/get_quran_usecase.dart';
import 'package:islamic_app/features/quran/domain/usecases/get_random_ayah_usecase.dart';
import 'package:islamic_app/features/quran/presentation/cubit/ayah_cubit/ayah_cubit.dart';
import 'package:islamic_app/features/quran/presentation/cubit/quran_cubit/quran_cubit.dart';
import 'package:islamic_app/features/quran/presentation/cubit/random_ayah_cubit/random_ayah_cubit.dart';
import 'package:islamic_app/features/reminders/data/data_sources/reminders_local_datasource.dart';
import 'package:islamic_app/features/reminders/data/models/reminder_model.dart';
import 'package:islamic_app/features/reminders/data/repositories/reminders_repository_impl.dart';
import 'package:islamic_app/features/reminders/domain/repositories/reminders_repository.dart';
import 'package:islamic_app/features/reminders/domain/usecases/add_reminder_usecase.dart';
import 'package:islamic_app/features/reminders/domain/usecases/update_reminder_usecase.dart';
import 'package:islamic_app/features/reminders/presentation/cubit/reminders_cubit.dart';
import 'package:islamic_app/features/tasbih/data/data_sources/tasbih_local_data_source.dart';
import 'package:islamic_app/features/tasbih/data/models/tasbih_model.dart';
import 'package:islamic_app/features/tasbih/data/repositories/tasbih_repository_impl.dart';
import 'package:islamic_app/features/tasbih/domain/repositories/tasbih_repository.dart';
import 'package:islamic_app/features/tasbih/domain/usecases/add_tasbih_usecase.dart';
import 'package:islamic_app/features/tasbih/domain/usecases/get_tasbih_usecase.dart';
import 'package:islamic_app/features/tasbih/domain/usecases/update_tasbih_usecase.dart';
import 'package:islamic_app/features/tasbih/presentation/cubit/tasbih_cubit.dart';

final sl = GetIt.instance;

void initServiceLocator() {
  /// External
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));

  /// DataSources
  sl.registerLazySingleton<QuranRemoteDataSource>(
    () => QuranRemoteDataSourceImpl(apiConsumer: sl()),
  );
  sl.registerLazySingleton<RemindersLocalDataSource>(
    () => RemindersLocalDataSourceImpl(sl<Box<ReminderModel>>()),
  );
  sl.registerLazySingleton<AdhkarLocalDataSource>(
    () => AdhkarLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<PrayerRemoteDataSource>(
    () => PrayerRemoteDataSourceImpl(apiConsumer: sl()),
  );
  sl.registerLazySingleton<TasbihLocalDataSource>(
    () => TasbihLocalDataSourceImpl(sl<Box<TasbihModel>>()),
  );
  
  /// Repositories
  sl.registerLazySingleton<QuranRepository>(
    () => QuranRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<RemindersRepository>(
    () => RemindersRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<AdhkarRepository>(
    () => AdhkarRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<PrayerRepository>(
    () => PrayerRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<TasbihRepository>(
    () => TasbihRepositoryImpl(localDataSource: sl()),
  );

  /// UseCases
  sl.registerLazySingleton(() => GetQuransUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAyahsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetRandomAyahUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddReminderUseCase(repository: sl())); 
  sl.registerLazySingleton(() => UpdateReminderUseCase(repository: sl())); 
  sl.registerLazySingleton(() => GetAdhkarUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetPrayerTimesUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAllTasbihsUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddTasbihUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateTasbihUseCase(repository: sl()));

  /// Cubits
  sl.registerFactory(() => QuranCubit(getQuransUseCase: sl()));
  sl.registerFactory(() => AyahCubit(getAyahsUseCase: sl()));
  sl.registerFactory(() => RandomAyahCubit(getRandomAyahUseCase: sl()));
  sl.registerFactory(() => RemindersCubit(
    addReminderUseCase: sl(), 
    updateReminderUseCase: sl(),
    repository: sl())
  );
  sl.registerFactory(() => AdhkarCubit(getAdhkarUseCase: sl()));
  sl.registerFactory(() => PrayerCubit(getPrayerTimesUseCase: sl()));
  sl.registerFactory(() => TasbihCubit(
    getAllTasbihs: sl(),
    saveTasbih: sl(),
    updateTasbih: sl(),
  ));
}
