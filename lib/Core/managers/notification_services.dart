import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:pulse/Core/utils/sql_database.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationServices {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static void onTap(NotificationResponse details) async {
    final payload = details.payload!;
    final parts = payload.split(',');
    final int indexOfScheduled = int.parse(parts[0].trim()); //0
    final title = parts[1].trim();
    final medId = parts[2].trim();

    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    if (details.payload != null && details.actionId == 'Remind_me_later') {
      final scheduledDate =
          tz.TZDateTime.now(tz.local).add(const Duration(minutes: 1));
      print('scheduledDate onTap: $scheduledDate');

      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
        'daily_scheduled_notification',
        'Daily Scheduled Notification',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: true,
        actions: <AndroidNotificationAction>[
          AndroidNotificationAction(
            'will_take_it',
            'I will took it ',
            icon: DrawableResourceAndroidBitmap('@mipmap/launcher_icon'),
          ),
        ],
      );

      const NotificationDetails notificationDetails =
          NotificationDetails(android: androidDetails);

      await flutterLocalNotificationsPlugin.zonedSchedule(
        details.id!,
        'Daily reminder to take your $title medication',
        'Please take your prescribed medication on time',
        scheduledDate,
        notificationDetails,
        payload: '$indexOfScheduled, $title, $medId',
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );

      print('User pressed Remind me later');
      print(details.id);
    } else if (details.actionId == 'will_take_it') {
      int? isTaken = await SqlDb().getIsTaken(int.parse(medId));
      isTaken = isTaken! + 1;
      await SqlDb().updateIsTaken(int.parse(medId), isTaken);
      String? periods = await SqlDb().getPeriods(int.parse(medId));
      List<int> listOfScheduled = [];
      listOfScheduled = periods!.split('').map(int.parse).toList();
      print(listOfScheduled);
      if (listOfScheduled.last == indexOfScheduled) {
        await SqlDb().updateIsTaken(int.parse(medId), 0);
        if (isTaken == listOfScheduled.length) {
          await SqlDb().updateHistory(int.parse(medId), '1');
        } else {
          await SqlDb().updateHistory(int.parse(medId), '0');
        }
      }
      print('User pressed I will took it ');
    }
  }

  Future<void> initialize() async {
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/launcher_icon'),
      iOS: DarwinInitializationSettings(),
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
    print("Notifications initialized");
  }

  Future<void> showScheduledNotification() async {
    print("showScheduledNotification");
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    var now = tz.TZDateTime.now(tz.local);
    List notificationList = await SqlDb().getAllNotifications();
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'daily_scheduled_notification',
      'Daily Scheduled Notification',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction(
          'Remind_me_later',
          'Remind me later',
          icon: DrawableResourceAndroidBitmap('@mipmap/launcher_icon'),
        ),
        AndroidNotificationAction(
          'will_take_it',
          'I will took it ',
          icon: DrawableResourceAndroidBitmap('@mipmap/launcher_icon'),
        ),
      ],
    );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    for (var notification in notificationList) {
      if (notification.notificationTime.isBefore(now)) {
        print(notification.notificationTime);
        print("Notification time is before now");
        cancelScheduledNotification(notification.id!);
        continue;
      }
      print("Notification time is after now");
      print(notification.notificationTime);
      String? medName = await SqlDb().getMedName(notification.medId!);
      await flutterLocalNotificationsPlugin.zonedSchedule(
        notification.id!,
        'Reminder to take your $medName medication',
        'Please take your prescribed medication on time',
        notification.notificationTime,
        notificationDetails,
        payload:
            '${notification.indexOfNotification}, $medName, ${notification.medId}',
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  Future<void> cancelAllScheduledNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> cancelScheduledNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
