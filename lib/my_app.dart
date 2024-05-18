import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/legalz_app.dart';
import 'package:legalz_hub_app/locator.dart';
import 'package:legalz_hub_app/screens/splash/splash_screen.dart';
import 'package:legalz_hub_app/services/general/network_info_service.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/logger.dart';
import 'package:async/async.dart';

class MyApp extends StatefulWidget {
  const MyApp(this.navigatorKey, {super.key});
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Box myBox = Hive.box(DatabaseBoxConstant.userInfo);
  bool isDialogueOfNoInternetConnectionAppear = false;
  bool hasConnectivity = false;

  final AsyncMemoizer _memoizer = AsyncMemoizer();
  Future fetchData() {
    return this._memoizer.runOnce(() async {
      await Future.delayed(Duration(seconds: 2));
      return initializeEveryThing();
    });
  }

  @override
  Widget build(BuildContext context) {
    // locator<MainContext>().setMainContext(context);
    // final Future<FirebaseApp> _initialization = kIsWeb ? _setupWebFirebase() : _setupMobileFirebase();

    return FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            logDebugMessage(message: "snapshot error. $snapshot");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            logDebugMessage(message: 'Initialize Firebase Done!!');

            return LegalzApp(
              navigatorKey: widget.navigatorKey,
              hasConnectivity: hasConnectivity,
            );
          }

          return SplashLoadingScreen();
        });
  }

  Future initializeEveryThing() async {
    await Hive.initFlutter();
    await Hive.openBox(DatabaseBoxConstant.userInfo);
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

    if (kIsWeb) {
      hasConnectivity = true;
      await _setupWebFirebase();
    } else {
      await _setupMobileFirebase();
    }
  }

  Future<bool> _initInternetConnection() async {
    final NetworkInfoService networkInfoService = NetworkInfoService();
    networkInfoService.initNetworkConnectionCheck();
    return networkInfoService.checkConnectivityonLunching();
  }

  Future<FirebaseApp> _setupMobileFirebase() async {
    return Firebase.initializeApp();
  }

  Future<FirebaseApp> _setupWebFirebase() async {
    return Firebase.initializeApp(
      options: const FirebaseOptions(
          projectId: "legalzhub",
          messagingSenderId: "427308149539",
          appId: "1:427308149539:web:18904d6b50e62afef7fa96",
          apiKey: "AIzaSyBRfHMFQFMDlefTp2Am4Srb3tj7lax7V-Q",
          authDomain: "legalzhub.firebaseapp.com",
          storageBucket: "legalzhub.appspot.com",
          measurementId: "G-FYY1QV12GF"),
    );
  }
}
