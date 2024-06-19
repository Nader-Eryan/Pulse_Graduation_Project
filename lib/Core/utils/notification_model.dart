import 'package:timezone/timezone.dart';

class NotificationModel {
  int? id;
  int medId;
  TZDateTime notificationTime;
  int indexOfNotification;

  NotificationModel({
    this.id,
    required this.medId,
    required this.notificationTime,
    required this.indexOfNotification,
  });

  Map<String, dynamic> toMap() {
    return {
      'medId': medId,
      'notificationTime': notificationTime.toIso8601String(),
      'indexOfNotification': indexOfNotification,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'],
      medId: map['medId'],
      notificationTime: TZDateTime.parse(local, map['notificationTime']),
      indexOfNotification: map['indexOfNotification'],
    );
  }
}
