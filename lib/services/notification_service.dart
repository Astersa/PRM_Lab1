import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../main.dart';

class NotificationService {
  // 10.5 – Trigger a local notification
  Future<void> showLoginSuccessNotification({required String username}) async {
    const androidDetails = AndroidNotificationDetails(
      'auth_channel',
      'Authentication',
      channelDescription: 'Login and session notifications',
      importance: Importance.high,
      priority: Priority.high,
    );
    const darwinDetails = DarwinNotificationDetails();
    const details =
        NotificationDetails(android: androidDetails, iOS: darwinDetails);

    await notificationsPlugin.show(
      0,
      'Login Successful',
      'Welcome back, $username!',
      details,
    );
  }
}
