import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/push_notifications/notification_manager.dart';

class FirebaseCloudMessagingUtil {
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  static dynamic initConfigure(BuildContext context) async {
    await _fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await _fcm.requestPermission();

    await _fcm.setAutoInitEnabled(true);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final RemoteNotification? notification = message.notification;
      if (notification != null) {
        NotificationManager.handleNotificationMsg(
            {message.notification!.title: message.notification!.body});
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final RemoteNotification? notification = message.notification;
      if (notification != null) {
        NotificationManager.handleNotificationMsg(
            message.data as Map<String?, String?>);
      }
    });

    await _fcm.getToken().then((value) async {
      log('Token: $value');
      final box = Hive.box(DatabaseBoxConstant.userInfo);
      await box.put(DatabaseFieldConstant.pushNotificationToken, value);
    });
  }
}
