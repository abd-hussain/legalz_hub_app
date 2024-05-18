import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/locator.dart';
import 'package:legalz_hub_app/main_context.dart';
import 'package:legalz_hub_app/utils/constants/constant.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/custom_gusture.dart';
import 'package:legalz_hub_app/utils/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LegalzApp extends StatefulWidget {
  const LegalzApp(
      {super.key, required this.navigatorKey, required this.hasConnectivity});
  final GlobalKey<NavigatorState> navigatorKey;
  final bool hasConnectivity;
  @override
  State<LegalzApp> createState() => LegalzAppState();

  static LegalzAppState? of(BuildContext context) {
    return context.findAncestorStateOfType<LegalzAppState>();
  }
}

class LegalzAppState extends State<LegalzApp> {
  bool isDialogueOfConeectionStatusAppear = false;
  late Box myBox = Hive.box(DatabaseBoxConstant.userInfo);

  void rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    locator<MainContext>().setMainContext(context);

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
      initialRoute: widget.hasConnectivity
          ? myBox.get(DatabaseFieldConstant.selectedCountryId) != null
              ? myBox.get(DatabaseFieldConstant.skipTutorials) != null
                  ? RoutesConstants.loginScreen
                  : RoutesConstants.tutorialsScreen
              : RoutesConstants.initialRoute
          : RoutesConstants.noInternetScreen,
    );
  }
}
