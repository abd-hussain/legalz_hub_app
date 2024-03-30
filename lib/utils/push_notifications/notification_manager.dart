import 'package:flutter/material.dart';
import 'package:legalz_hub_app/locator.dart';
import 'package:legalz_hub_app/main_context.dart';
import 'package:legalz_hub_app/utils/logger.dart';

class NotificationManager {
  static BuildContext? context;
  static dynamic init({required BuildContext context}) {
    context = context;
  }

  //this method used when notification come and app is closed or in background and
  // user click on it, i will left it empty for you
  static dynamic handleDataMsg(Map<String, dynamic> data) {}

  //this our method called when notification come and app is foreground
  static dynamic handleNotificationMsg(Map<String?, String?> message) {
    logDebugMessage(message: "from mangger  $message");

    ScaffoldMessenger.of(locator<MainContext>().mainContext!).showSnackBar(
      SnackBar(
        content: Text(message.keys.first!),
      ),
    );
  }
}
