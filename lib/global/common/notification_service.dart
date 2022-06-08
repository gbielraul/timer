import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timer/global/common/routes.dart';
import 'package:timezone/timezone.dart' as timezone;
import 'package:timezone/data/latest_all.dart' as timezone;

class NotificationService {
  NotificationService() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupNotifications();
  }

  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;

  void _onSelectNotification(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      Navigator.of(Routes.navigatorKey!.currentContext!)
          .pushReplacementNamed(payload);
    }
  }

  Future _setupTimezone() async {
    timezone.initializeTimeZones();
    final String timezoneName = await FlutterNativeTimezone.getLocalTimezone();
    timezone.setLocalLocation(timezone.getLocation(timezoneName));
  }

  Future _initializeNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    await localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: android,
      ),
      onSelectNotification: _onSelectNotification,
    );
  }

  Future _setupNotifications() async {
    await _setupTimezone();
    await _initializeNotifications();
  }

  showNotification(CustomNotification notification) {
    androidDetails = const AndroidNotificationDetails(
      'timer_is_over',
      'Reminder',
      channelDescription: 'Reminder channel',
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
    );

    localNotificationsPlugin.show(
      notification.id,
      notification.title,
      notification.body,
      NotificationDetails(
        android: androidDetails,
      ),
      payload: notification.payload,
    );
  }

  Future checkForNotifications() async {
    final details =
        await localNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      _onSelectNotification(details.payload);
    }
  }
}

class CustomNotification {
  CustomNotification({
    this.id = 0,
    this.title,
    this.body,
    this.payload,
  });

  int id;
  String? title;
  String? body;
  String? payload;
}
