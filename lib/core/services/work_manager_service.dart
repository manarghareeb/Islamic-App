import 'package:islamic_app/core/services/local_notifications_service.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  void registerPeriodicTask() async {
    await Workmanager().registerPeriodicTask(
      'uniqueName',
      'periodicTaskName',
      frequency: const Duration(seconds: 15),
    );
  }

  void registerMyTask() async {
    await Workmanager().registerOneOffTask(
      'myUniqueTaskId',
      'myTaskName',
      //inputData: {'key': 'value'},
    );
  }

  Future<void> initialize() async {
    await Workmanager().initialize(actionTask, isInDebugMode: true);
    registerMyTask();
    //registerPeriodicTask();
  }

  void cancelTask(String taskId) {
    Workmanager().cancelByUniqueName(taskId);
  }
}

@pragma('vm:entry-point')
void actionTask() {
  Workmanager().executeTask((task, inputData) async {
    try {
      await LocalNotificationsService.init();
      await LocalNotificationsService.showBasicNotification();
      await LocalNotificationsService.showDaiSchduledNotification();
      print("Background Task Executed: $task with inputData: $inputData");
      return Future.value(true);
    } catch (e) {
      print("Background Task Error: $e");
      return Future.value(false);
    }
  });
}
