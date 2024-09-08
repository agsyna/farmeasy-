import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  bool _isNotificationSelected = false;

  static final NotificationService _singleton =
      NotificationService._internal();

  factory NotificationService() {
    return _singleton;
  }

  NotificationService._internal() {
    initializeFcm();
  }

  void initializeFcm() async {
    // Android initialization
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS initialization
    

    // Initialization settings for both Android and iOS
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    // Initialize notifications
    await notificationsPlugin.initialize(
      initializationSettings,
    );

    // Request permissions for iOS (if needed)
    await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Listen for messages
    FirebaseMessaging.onMessage.listen(onMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(onResume);

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

    // Save the device token or subscribe to a topic
    _saveDeviceToken();
  }

  // Handle foreground notifications
  Future<void> onMessage(RemoteMessage message) async {
    print('Foreground message received: ${message.notification?.title}');

    // Show local notification when the app is in the foreground
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await notificationsPlugin.show(
      message.data.hashCode,
      message.notification?.title,
      message.notification?.body,
      platformDetails,
      payload: message.data['route'] ?? 'default',
    );
  }

  // Handle notification click when the app is in the background
  Future<void> onResume(RemoteMessage message) async {
    print('Notification opened from background: ${message.data}');
    handleNotificationNavigation(message.data);
  }

  // Handle notification click when the app is launched by a notification
  Future<void> onSelectNotification(String? payload) async {
    if (!_isNotificationSelected) {
      _isNotificationSelected = true;
      handleNotificationNavigation({'route': payload});
      _isNotificationSelected = false;
    }
  }

  // Handle background messages
  static Future<void> backgroundMessageHandler(RemoteMessage message) async {
    print('Background message received: ${message.notification?.title}');
  }

  // Save device token for FCM or subscribe to a topic
  void _saveDeviceToken() async {
    String? fcmToken = await _fcm.getToken();
    print('FCM Token: $fcmToken');
    // Subscribe to a topic or save the token in the backend
  }

  // iOS local notification handler
  Future<void> onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // Handle iOS foreground notification
  }

  // Handle navigation based on notification data
  void handleNotificationNavigation(Map<String, dynamic> data) {
    var routeName = data['route'];
    // Navigate to specific route
    print('Navigate to: $routeName');
  }
}
