import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../constants/database_constant.dart';
import 'notification_manager.dart';

class FirebaseCloudMessagingUtil {
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  static dynamic initConfigure(BuildContext context) async {
    await _fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    _fcm.setAutoInitEnabled(true);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        NotificationManager.handleNotificationMsg(
            {message.notification!.title: message.notification!.body});
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        NotificationManager.handleNotificationMsg(
            message.data as Map<String?, String?>);
      }
    });

    _fcm.getToken().then((value) async {
      log('Token: $value');
      final box = Hive.box(DatabaseBoxConstant.userInfo);
      await box.put(DatabaseFieldConstant.pushNotificationToken, value);
    });
  }
}
