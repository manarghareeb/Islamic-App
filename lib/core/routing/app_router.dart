import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:islamic_app/core/di/service_locator.dart';
import 'package:islamic_app/features/adhkar/domain/entities/adhkar_category_entity.dart';
import 'package:islamic_app/features/adhkar/presentation/cubit/adhkar_cubit.dart';
import 'package:islamic_app/features/adhkar/presentation/views/athkar_details_screen.dart';
import 'package:islamic_app/features/adhkar/presentation/views/athkar_screen.dart';
import 'package:islamic_app/features/home/presentation/views/home_screen.dart';
import 'package:islamic_app/features/onboarding/presentation/views/onboarding_screen.dart';
import 'package:islamic_app/features/onboarding/presentation/views/splash_screen.dart';
import 'package:islamic_app/features/prayer_times/domain/entities/prayer_time_entity.dart';
import 'package:islamic_app/features/prayer_times/presentation/cubit/prayer_cubit.dart';
import 'package:islamic_app/features/prayer_times/presentation/views/payer_times_screen.dart';
import 'package:islamic_app/features/quran/domain/entities/quran_entity.dart';
import 'package:islamic_app/features/quran/presentation/cubit/ayah_cubit/ayah_cubit.dart';
import 'package:islamic_app/features/quran/presentation/cubit/quran_cubit/quran_cubit.dart';
import 'package:islamic_app/features/quran/presentation/cubit/random_ayah_cubit/random_ayah_cubit.dart';
import 'package:islamic_app/features/quran/presentation/views/quran_details_screen.dart';
import 'package:islamic_app/features/quran/presentation/views/quran_screen.dart';
import 'package:islamic_app/features/reminders/presentation/cubit/reminders_cubit.dart';
import 'package:islamic_app/features/reminders/presentation/views/reminders_screen.dart';
import 'package:islamic_app/features/settings/presentation/views/language_selection_screen.dart';
import 'package:islamic_app/features/settings/presentation/views/location_permission_screen.dart';
import 'package:islamic_app/features/tasbih/presentation/cubit/tasbih_cubit.dart';
import 'package:islamic_app/features/tasbih/presentation/views/tasbih_screen.dart';

abstract class AppRouter {
  static const String onboardingScreen = '/onboardingScreen';
  static const String splashScreen = '/splashScreen';
  static const String homeScreen = '/homeScreen';
  static const String quranScreen = '/quranScreen';
  static const String quranDetailsScreen = '/quranDetailsScreen';
  static const String languageSelectionScreen = '/languageSelectionScreen';
  static const String locationPermissionScreen = '/locationPermissionScreen';
  static const String payerTimesScreen = '/payerTimesScreen';
  static const String athkarScreen = '/athkarScreen';
  static const String athkarDetailsScreen = '/athkarDetailsScreen';
  static const String remindersScreen = '/remindersScreen';
  static const String tasbihScreen = '/tasbihScreen';

  static final route = GoRouter(
    initialLocation: splashScreen,
    routes: [
      GoRoute(
        path: splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: onboardingScreen,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: homeScreen,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<RandomAyahCubit>()..fetchRandomAyah(),
            ),
            BlocProvider(
              create: (context) => sl<PrayerCubit>()..fetchPrayerTimes(),
            ),
          ],
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        path: quranScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<QuranCubit>()..fetchQurans(),
          child: const QuranScreen(),
        ),
      ),
      GoRoute(
        path: quranDetailsScreen,
        builder: (context, state) {
          final quranEntity = state.extra as QuranEntity;
          return BlocProvider(
            create: (context) =>
                sl<AyahCubit>()..fetchQuranAyahs(quranEntity.number),
            child: QuranDetailsScreen(initialQuranData: quranEntity),
          );
        },
      ),
      GoRoute(
        path: locationPermissionScreen,
        builder: (context, state) => const LocationPermissionScreen(),
      ),
      GoRoute(
        path: languageSelectionScreen,
        builder: (context, state) => const LanguageSelectionScreen(),
      ),
      GoRoute(
        path: payerTimesScreen,
        builder: (context, state) {
          final prayerTimes = state.extra as PrayerTimesEntity;
          return BlocProvider(
            create: (context) => sl<PrayerCubit>()..fetchPrayerTimes(),
            child: PayerTimesScreen(prayerTimes: prayerTimes),
          );
        },
      ),
      GoRoute(
        path: athkarScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<AdhkarCubit>()..fetchAllAdhkar(),
          child: const AthkarScreen(),
        ),
      ),
      GoRoute(
        path: athkarDetailsScreen,
        builder: (context, state) {
          final category = state.extra as AdhkarCategoryEntity;
          return AthkarDetailsScreen(category: category);
        },
      ),
      GoRoute(
        path: remindersScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<RemindersCubit>()..loadReminders(),
          child: const RemindersScreen(),
        ),
      ),
      GoRoute(
        path: tasbihScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<TasbihCubit>()..loadTasbihs(),
          child: const TasbihScreen(),
        ),
      ),
    ],
  );
}
