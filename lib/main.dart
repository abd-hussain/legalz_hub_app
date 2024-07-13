import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:legalz_hub_app/my_app.dart';
import 'package:legalz_hub_app/utils/error/exceptions.dart';
import 'package:legalz_hub_app/utils/logger.dart';

//TODO: Upgrade flutter verison and all of the packages
//TODO: check all of iO and make it disaple for web
//TODO: iOS list in Home Page and account not working
//TODO: handle free booking for all attorney
//TODO: send notification when any one book for attorney
//TODO: send notification when the meeting near 5 min

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runZonedGuarded(() {
    logDebugMessage(message: 'Application Started ...');
    WidgetsFlutterBinding.ensureInitialized();

    runApp(
      MyApp(
        navigatorKey,
      ),
    );
  }, (error, stackTrace) {
    if (error is DioException) {
      final exception = error.error;
      if (exception is HttpException) {
        debugPrint("MAIN");
        debugPrint(exception.status.toString());
        debugPrint(exception.message);
        debugPrint(exception.requestId);
      }
    } else if (error is ConnectionException) {}
  });
}
