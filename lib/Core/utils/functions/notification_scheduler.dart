import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pulse/Core/utils/functions/notification_model.dart';
import 'package:pulse/Core/utils/sql_database.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

Future<void> notificationScheduler({
  required List<int> listOfScheduled,
  required int medId,
}) async {
  tz.initializeTimeZones();
  final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(currentTimeZone));
  var now = tz.TZDateTime.now(tz.local);
  List<TimeOfDay> listScheduledTime = await fetchTimeFromFirebase();
  //print('listScheduledTime: $listScheduledTime');

  tz.TZDateTime getConvertedTime(TimeOfDay time) {
    return tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute);
  }

  tz.TZDateTime convertTimeOfBreakfast = getConvertedTime(listScheduledTime[0]);
  tz.TZDateTime convertTimeOfLunch = getConvertedTime(listScheduledTime[1]);
  tz.TZDateTime convertTimeOfDinner = getConvertedTime(listScheduledTime[2]);
  tz.TZDateTime scheduledDate;

  for (var index in listOfScheduled) {
    switch (index) {
      case 0:
        scheduledDate = convertTimeOfBreakfast.add(const Duration(minutes: -1));
        break;
      case 1:
        scheduledDate = convertTimeOfBreakfast.add(const Duration(minutes: 1));
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
    while (scheduledDate.isBefore(now.add(const Duration(minutes: 10)))) {
      //print('ScheduledDate: $scheduledDate');
      NotificationModel notification = NotificationModel(
        medId: medId,
        notificationTime: scheduledDate,
        indexOfNotification: index,
      );
      await SqlDb().insert('notifications', notification.toMap());
      scheduledDate = scheduledDate.add(const Duration(minutes: 5));
    }
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
