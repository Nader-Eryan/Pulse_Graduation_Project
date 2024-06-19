import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:pulse/Core/utils/edit_database.dart';
import 'package:pulse/Features/home/presentation/manager/meds_controller.dart';
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

    String? isTaken = '';
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
      isTaken = await USqlDb().getIsTaken(int.parse(medId));
      print('isTaken before replacement: $isTaken');
      isTaken =
          isTaken?.replaceRange(indexOfScheduled, indexOfScheduled + 1, "1");
      print('isTaken after replacement: $isTaken');
      if (isTaken != null) {
        await USqlDb().updateIsTaken(int.parse(medId), isTaken);
        await MedsController().getMeds();
      }

      String? periods = await USqlDb().getPeriods(int.parse(medId));
      List<int> listOfScheduled = [];
      print('periods: $periods');
      listOfScheduled = periods!.split('').map(int.parse).toList();
      print('listOfScheduled: ${listOfScheduled.last}');
      if (listOfScheduled.last == indexOfScheduled) {
        if (isTaken!.contains("0")) {
          await USqlDb().updateHistory(int.parse(medId), '0');
          await MedsController().getMeds();
        } else {
          await USqlDb().updateHistory(int.parse(medId), '1');
          await MedsController().getMeds();
        }
        print(listOfScheduled.length);
        isTaken = List.filled(listOfScheduled.length, '0').join('');
        print('after last time isTaken: $isTaken');
        await USqlDb().updateIsTaken(int.parse(medId), isTaken);
        await MedsController().getMeds();
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

  static Future<void> showScheduledNotification({
    required int medId,
    required List<int> listOfScheduled,
    required String title,
  }) async {
    print('showScheduledNotification called');
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    var now = tz.TZDateTime.now(tz.local);
    List<TimeOfDay> listScheduledTime = await fetchTimeFromFirebase();
    print('listScheduledTime: $listScheduledTime');

    tz.TZDateTime getConvertedTime(TimeOfDay time) {
      return tz.TZDateTime(
          tz.local, now.year, now.month, now.day, time.hour, time.minute);
    }

    tz.TZDateTime convertTimeOfBreakfast =
        getConvertedTime(listScheduledTime[0]);
    tz.TZDateTime convertTimeOfLunch = getConvertedTime(listScheduledTime[1]);
    tz.TZDateTime convertTimeOfDinner = getConvertedTime(listScheduledTime[2]);
    tz.TZDateTime scheduledDate;

    const AndroidNotificationDetails androidDetails =
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
        NotificationDetails(android: androidDetails);
    String notificationIDs = '';
    String notificationTimes = '';

    for (int i = 0; i < listOfScheduled.length; i++) {
      switch (i) {
        case 0:
          scheduledDate =
              convertTimeOfBreakfast.add(const Duration(minutes: -1));
          break;
        case 1:
          scheduledDate =
              convertTimeOfBreakfast.add(const Duration(minutes: 1));
          break;
        case 2:
          scheduledDate = convertTimeOfLunch.add(const Duration(minutes: -1));
          break;
        case 3:
          scheduledDate = convertTimeOfLunch.add(const Duration(minutes: 1));
          break;
        case 4:
          scheduledDate = convertTimeOfDinner.add(const Duration(minutes: -1));
          break;
        case 5:
          scheduledDate = convertTimeOfDinner.add(const Duration(minutes: 1));
          break;
        default:
          return;
      }
      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(minutes: 1));
        print('scheduledDate added: $scheduledDate');
      }

      int notificationId = i + medId + Random().nextInt(1000);
      while (scheduledDate.isBefore(now.add(const Duration(minutes: 10)))) {
        print('notificationId: $notificationId');
        print('ScheduledDate: $scheduledDate');
        await flutterLocalNotificationsPlugin.zonedSchedule(
          notificationId,
          'Daily reminder to take your $title medication',
          'Please take your prescribed medication on time',
          scheduledDate,
          notificationDetails,
          payload: '$i, $title, $medId',
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time,
        );
        notificationIDs += '$notificationId,';
        notificationTimes += '$notificationTimes,';
        notificationId++;
        scheduledDate = scheduledDate.add(const Duration(minutes: 5));
      }
    }
    print('notificationIDs: $notificationIDs');
    print('notificationTimes: $notificationTimes');
    if (notificationIDs.isNotEmpty && notificationTimes.isNotEmpty) {
      await USqlDb().updateNotificationIDs(medId, notificationIDs);
      await USqlDb().updateNotificationTimes(medId, notificationTimes);
      await MedsController().getMeds();
    }
  }

  static Future<void> cancelAllScheduledNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  static Future<void> cancelScheduledNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}

Future<List<TimeOfDay>> fetchTimeFromFirebase() async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String uid = FirebaseAuth.instance.currentUser!.uid;
  DocumentSnapshot docSnapshot = await users.doc(uid).get();

  TimeOfDay scheduledTimeBF =
      TimeOfDay(hour: docSnapshot['bfH'], minute: docSnapshot['bfM']);
  TimeOfDay scheduledTimeLU =
      TimeOfDay(hour: docSnapshot['luH'], minute: docSnapshot['luM']);
  TimeOfDay scheduledTimeDI =
      TimeOfDay(hour: docSnapshot['diH'], minute: docSnapshot['diM']);

  return [scheduledTimeBF, scheduledTimeLU, scheduledTimeDI];
}
