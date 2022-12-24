import 'dart:convert';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class NotificationServices {
  static final _notifications = FlutterLocalNotificationsPlugin();
  showNotification({title, description,}) async {
    print('iu am clicked');
    final bool? result = await _notifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    tz.initializeTimeZones();
    await _notifications.periodicallyShow(
        0,
        title,
        description,
        RepeatInterval.hourly,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'channel id',
            'channel name',
            channelDescription: 'channel description',
            importance: Importance.max,
          ),
          iOS: IOSNotificationDetails(
            threadIdentifier: 'thread_id',
            presentAlert: true,
            presentBadge: true,
            presentSound: true,

          ),
        ),
        payload: 'bb.abs',
      androidAllowWhileIdle : true,

    //   uiLocalNotificationDateInterpretation :UILocalNotificationDateInterpretation.absoluteTime,
    // matchDateTimeComponents: DateTimeComponents.time
    );


  }


}
