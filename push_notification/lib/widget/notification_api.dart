import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  //...
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();
  static final location = tz.getLocation('America/Detroit');

  static final Duration offsetTime = DateTime.now().timeZoneOffset;

  static Future initializetimezone() async {
    tz.initializeTimeZones();
  }

  static _notificationDetails(int? id) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
          id.toString(), 'channel_name', 'channel_description',
          importance: Importance.max, priority: Priority.high),
    );
  }

  //show notification
  static showNotification({
    int? id,
    String? title,
    String? body,
    String? payload,
  }) =>
      () {
        //..
        _notifications.show(2, title, body, _notificationDetails(id),
            payload: payload);
      };

  // show schedule notification
  static showScheduleNotification({
    int? id,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) =>
      () async {
        //..

        _notifications.zonedSchedule(
          2,
          title,
          body,
          tz.TZDateTime.from(_scheduleSeconds(scheduledDate), location),
          // await _scheduleDaily(Time(1)),
          _notificationDetails(id),
          payload: payload,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          //matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        );
      };

  static Future init({bool initScheduled = false}) async {
    //...
    final settingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final ios = IOSInitializationSettings();

    final setting = InitializationSettings(android: settingsAndroid, iOS: ios);

    await _notifications.initialize(setting,
        onSelectNotification: (payload) async {
      //...
      onNotification.add(payload);
    });
  }

  static Future<tz.TZDateTime> _scheduleDaily(Time time) async {
    final now = tz.TZDateTime.now(location);

    final scheduledDatetime = tz.TZDateTime(tz.local, now.year, now.month,
        now.day, time.hour, time.minute, time.second);
    return scheduledDatetime.isBefore(now)
        ? scheduledDatetime.add(Duration(days: 1))
        : scheduledDatetime;
  }

  static DateTime _scheduleSeconds(DateTime scheduledDate) {
    final now = tz.TZDateTime.now(tz.local);

    return scheduledDate.isBefore(now)
        ? scheduledDate.add(Duration(seconds: 12))
        : scheduledDate;
  }
}
