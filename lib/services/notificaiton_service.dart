import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String>();

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
          'channel id', 'channel name', 'channel description',
          importance: Importance.max),
      iOS: IOSNotificationDetails(),
    );
  }


  static Future init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    final settings = InitializationSettings(android: android, iOS: iOS);

     tz.initializeTimeZones();
    var localTime = tz.getLocation('Europe/London');
    tz.setLocalLocation(localTime);

    await _notifications.initialize(settings,
        onSelectNotification: (payload) async {
      onNotifications.add(payload);
    });
  }

  static Future showNotification(
          {int id = 0, String title, String body, String payload}) async =>
      _notifications.show(id, title, body, await _notificationDetails(),
          payload: payload);

  static Future showScheduledNotification({
    int id = 0,
    String title,
    String body,
    String payload,
  int scheduledHour,
   int scheduledMin,
  }) async =>
      _notifications.zonedSchedule(
        id,
        title,
        body,
        _scheduledDaily(Time(scheduledHour,scheduledMin)),
        await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );

  static tz.TZDateTime _scheduledDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
      time.second,
    );

    return scheduledDate.isBefore(now) ? scheduledDate.add(Duration(days: 1)) : scheduledDate;
  }


  static List<tz.TZDateTime> _scheduleWeekly(Time time,
      {List<int> days}) {
    return days.map((day) {
      tz.TZDateTime scheduledDate = _scheduledDaily(time);

      while (day != scheduledDate.weekday) {
        scheduledDate = scheduledDate.add(Duration(days: 1));
      }
      return scheduledDate;
    }).toList();
  }
}
