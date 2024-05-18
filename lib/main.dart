import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:legalz_hub_app/my_app.dart';
import 'package:legalz_hub_app/utils/error/exceptions.dart';
import 'package:legalz_hub_app/utils/logger.dart';

//TODO: Upgrade flutter verison and all of the packages
//TODO: check all of iO and make it disaple for web
//TODO: handle internet coneection checkup inside application

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runZonedGuarded(() {
    logDebugMessage(message: 'Application Started ...');
    WidgetsFlutterBinding.ensureInitialized();

    // await Hive.initFlutter();
    // await Hive.openBox(DatabaseBoxConstant.userInfo);
    // bool hasConnectivity = true;
    // await setupLocator();

    // if (!kIsWeb) {
    //   hasConnectivity = await _initInternetConnection();

    //   await MobileAds.instance.initialize();
    //   await MobileAds.instance.updateRequestConfiguration(
    //     RequestConfiguration(
    //         testDeviceIds: ['33BE2250B43518CCDA7DE426D04EE231']),
    //   );
    // }
    // await SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
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
    }
  });
}
