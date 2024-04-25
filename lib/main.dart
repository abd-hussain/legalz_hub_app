import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/locator.dart';
import 'package:legalz_hub_app/my_app.dart';
import 'package:dio/dio.dart';
import 'package:legalz_hub_app/services/general/network_info_service.dart';
import 'package:legalz_hub_app/utils/error/exceptions.dart';
import 'package:legalz_hub_app/utils/logger.dart';

//TODO: Upgrade flutter verison and all of the packages
//TODO: check all of iO and make it disaple for web
//TODO: handle internet coneection checkup inside application

//TODO: Mixed Content: The page at 'https://legalzhub.firebaseapp.com/' was loaded over HTTPS, but requested an insecure XMLHttpRequest endpoint 'http://167.99.212.137/filter/countries'. This request has been blocked; the content must be served over HTTPS.

void main() {
  runZonedGuarded(() async {
    logDebugMessage(message: 'Application Started ...');
    WidgetsFlutterBinding.ensureInitialized();

    await Hive.initFlutter();
    await Hive.openBox(DatabaseBoxConstant.userInfo);
    bool hasConnectivity = true;
    await setupLocator();

    if (!kIsWeb) {
      hasConnectivity = await _initInternetConnection();

      await MobileAds.instance.initialize();
      await MobileAds.instance.updateRequestConfiguration(
        RequestConfiguration(
            testDeviceIds: ['33BE2250B43518CCDA7DE426D04EE231']),
      );
    }
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    runApp(
      MyApp(isConnected: hasConnectivity),
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

Future<bool> _initInternetConnection() async {
  NetworkInfoService networkInfoService = NetworkInfoService();
  networkInfoService.initNetworkConnectionCheck();
  return await networkInfoService.checkConnectivityonLunching();
}
