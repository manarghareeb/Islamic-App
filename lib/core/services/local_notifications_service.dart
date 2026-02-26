import 'dart:async';
import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz_date;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationsService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
      StreamController();

  static void onTap(NotificationResponse notificationResponse) {
    streamController.add(notificationResponse);
  }

  static Future init() async {
    await configureLocalTimeZone();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  static Future<void> requestPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestExactAlarmsPermission();
  }

  static Future<void> configureLocalTimeZone() async {
    try {
      tz_date.initializeTimeZones();
      final timeZoneName = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timeZoneName.identifier));
      log("TimeZone initialized: $timeZoneName");
    } catch (e) {
      log("Error initializing timezone: $e");
    }
  }

  static Future showBasicNotification() async {
    NotificationDetails notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
        'basic_channel_id',
        'Basic Channel',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
    await flutterLocalNotificationsPlugin.show(
      id: 0,
      title: 'Basic Notification',
      body: 'This is a basic notification',
      notificationDetails: notificationDetails,
      payload: 'Basic Notification Payload',
    );
  }

  /*static Future showRepeatedNotification() async {
    NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'repeated_channel_id',
        'Repeated Channel',
        importance: Importance.max,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound('sound1'),
      ),
    );
    await flutterLocalNotificationsPlugin.periodicallyShow(
      repeatInterval: RepeatInterval.everyMinute,
      androidScheduleMode: AndroidScheduleMode.inexact,
      id: 1,
      title: 'Repeated Notification',
      body: 'This is a repeated notification',
      notificationDetails: notificationDetails,
      payload: 'Repeated Notification Payload',
    );
  }*/

  /*static Future showScheduledNotification() async {
    NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'scheduled_channel_id',
        'Scheduled Channel',
        importance: Importance.max,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound('sound2'),
      ),
    );

    final scheduledDate = tz.TZDateTime(tz.local, 2026, 1, 31, 21, 6, 0);
    log('Scheduling notification at: $scheduledDate in ${tz.local.name}');

    await flutterLocalNotificationsPlugin.zonedSchedule(
      scheduledDate: tz.TZDateTime.now(
        tz.local,
      ).add(const Duration(seconds: 10)),
      //scheduledDate: scheduledDate,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      id: 2,
      title: 'Scheduled Notification',
      body: 'This is a scheduled notification',
      notificationDetails: notificationDetails,
      payload: 'Scheduled Notification Payload',
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }*/

  static Future<void> showDaiSchduledNotification() async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'ultra_high_importance_channel_v2',
      'Important Reminders',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      playSound: true,
      enableVibration: true,
    );
    NotificationDetails details = const NotificationDetails(android: android);
    tz_date.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
    var currentTime = tz.TZDateTime.now(tz.local);
    /*log("currentTime.year:${currentTime.year}");
    log("currentTime.month:${currentTime.month}");
    log("currentTime.day:${currentTime.day}");
    log("currentTime.hour:${currentTime.hour}");
    log("currentTime.minute:${currentTime.minute}");
    log("currentTime.second:${currentTime.second}");
    var scheduleTime = tz.TZDateTime(
      tz.local,
      currentTime.year,
      currentTime.month,
      currentTime.day,
      currentTime.hour,
      35,
    );
    log("scheduledTime.year:${scheduleTime.year}");
    log("scheduledTime.month:${scheduleTime.month}");
    log("scheduledTime.day:${scheduleTime.day}");
    log("scheduledTime.hour:${scheduleTime.hour}");
    log("scheduledTime.minute:${scheduleTime.minute}");
    log("scheduledTime.second:${scheduleTime.second}");
    if (scheduleTime.isBefore(currentTime)) {
      scheduleTime = scheduleTime.add(const Duration(hours: 1));
      log("AfterAddedscheduledTime.year:${scheduleTime.year}");
      log("AfterAddedscheduledTime.month:${scheduleTime.month}");
      log("AfterAddedscheduledTime.day:${scheduleTime.day}");
      log("AfterAddedscheduledTime.hour:${scheduleTime.hour}");
      log("AfterAddedscheduledTime.minute:${scheduleTime.minute}");
      log("AfterAddedscheduledTime.second:${scheduleTime.second}");
      log('Added Duration to scheduled time');
    }*/
    var scheduleDate = currentTime.add(const Duration(seconds: 10));
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id: 3,
      title: 'نجحت التجربة! 🎉',
      body: 'ذا الإشعار قادم من الخلفية بدقة',
      // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
      scheduledDate: scheduleDate,
      notificationDetails: details,
      payload: 'zonedSchedule',
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /*static Future showDailyScheduledNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        'Daily Notifications',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    log('Next Daily Notification at: $scheduledDate');
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      notificationDetails: notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'Daily Notification Payload',
    );
  }*/

  static Future cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id: id);
  }
}
