import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/locator.dart';
import 'package:legalz_hub_app/main_context.dart';
import 'package:legalz_hub_app/utils/constants/constant.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/custom_gusture.dart';
import 'package:legalz_hub_app/utils/logger.dart';
import 'package:legalz_hub_app/utils/routes.dart';

BuildContext? buildContext;

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.isConnected,
  });
  final bool isConnected;

  static MyAppState? of(BuildContext context) {
    buildContext = context;
    return context.findAncestorStateOfType<MyAppState>();
  }

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late Box myBox = Hive.box(DatabaseBoxConstant.userInfo);

  void rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    locator<MainContext>().setMainContext(context);
    final Future<FirebaseApp> _initialization =
        kIsWeb ? _setupWebFirebase() : _setupMobileFirebase();

    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            logDebugMessage(message: "snapshot error. $snapshot");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            logDebugMessage(message: 'Initialize Firebase Done!!');

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              onGenerateTitle: (BuildContext context) {
                return AppConstant.appName;
              },
              locale: myBox.get(DatabaseFieldConstant.language) != null
                  ? Locale(myBox.get(DatabaseFieldConstant.language))
                  : const Locale("en"),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', ''),
                Locale('ar', ''),
              ],
              theme: ThemeData(useMaterial3: false),
              scrollBehavior: MyCustomScrollBehavior(),
              onGenerateRoute: (settings) {
                return PageRouteBuilder(
                    transitionsBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                        Widget child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    },
                    settings: RouteSettings(arguments: settings.arguments),
                    transitionDuration: const Duration(milliseconds: 100),
                    pageBuilder: (_, __, ___) => routes[settings.name]!);
              },
              initialRoute: widget.isConnected
                  ? myBox.get(DatabaseFieldConstant.selectedCountryId) != null
                      ? myBox.get(DatabaseFieldConstant.skipTutorials) != null
                          ? RoutesConstants.loginScreen
                          : RoutesConstants.tutorialsScreen
                      : RoutesConstants.initialRoute
                  : RoutesConstants.noInternetScreen,
            );
          }

          return Loading();
        });
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

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: Container(
          child: Text("Loading..."),
        ),
      ),
    ));
  }
}
