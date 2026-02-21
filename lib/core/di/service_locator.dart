import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:islamic_app/core/api/api_consumer.dart';
import 'package:islamic_app/core/api/dio_consumer.dart';
import 'package:islamic_app/features/quran/data/data_sources/quran_remote_data_source.dart';
import 'package:islamic_app/features/quran/data/repositories/quran_repository_impl.dart';
import 'package:islamic_app/features/quran/domain/repositories/quran_repository.dart';
import 'package:islamic_app/features/quran/domain/usecases/get_ayahs_use_case.dart';
import 'package:islamic_app/features/quran/domain/usecases/get_quran_usecase.dart';
import 'package:islamic_app/features/quran/domain/usecases/get_random_ayah_usecase.dart';
import 'package:islamic_app/features/quran/presentation/cubit/ayah_cubit/ayah_cubit.dart';
import 'package:islamic_app/features/quran/presentation/cubit/quran_cubit/quran_cubit.dart';
import 'package:islamic_app/features/quran/presentation/cubit/random_ayah_cubit/random_ayah_cubit.dart';

final sl = GetIt.instance;

void initServiceLocator() {
  /// External
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));

  /// DataSources
  sl.registerLazySingleton<QuranRemoteDataSource>(
    () => QuranRemoteDataSourceImpl(apiConsumer: sl()),
  );
  
  /// Repositories
  sl.registerLazySingleton<QuranRepository>(
    () => QuranRepositoryImpl(remoteDataSource: sl()),
  );

  /// UseCases
  sl.registerLazySingleton(() => GetQuransUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAyahsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetRandomAyahUseCase(repository: sl()));

  /// Cubits
  sl.registerFactory(() => QuranCubit(getQuransUseCase: sl()));
  sl.registerFactory(() => AyahCubit(getAyahsUseCase: sl()));
  sl.registerFactory(() => RandomAyahCubit(getRandomAyahUseCase: sl()));
}
