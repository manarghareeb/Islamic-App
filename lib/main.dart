import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:islamic_app/core/cache/cache_helper.dart';
import 'package:islamic_app/core/di/service_locator.dart';
import 'package:islamic_app/core/routing/app_router.dart';
import 'package:islamic_app/core/services/local_notifications_service.dart';
import 'package:islamic_app/features/reminders/data/models/reminder_model.dart';
import 'package:islamic_app/features/tasbih/data/models/tasbih_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ReminderModelAdapter());
  Hive.registerAdapter(TasbihModelAdapter());
  final remindersBox = await Hive.openBox<ReminderModel>('reminders');
  final tasbihBox = await Hive.openBox<TasbihModel>('tasbihs');
  sl.registerLazySingleton(() => remindersBox);
  sl.registerLazySingleton(() => tasbihBox);

  await CacheHelper.init();
  initServiceLocator();
  await LocalNotificationsService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Cairo',
        ),
        routerConfig: AppRouter.route,
      ),
    );
  }
}
