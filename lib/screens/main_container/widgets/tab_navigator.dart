import 'package:flutter/material.dart';
import 'package:legalz_hub_app/utils/routes.dart';

class TabNavigator extends StatelessWidget {
  final String initialRoute;
  const TabNavigator({super.key, required this.initialRoute});
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: initialRoute,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => routes[settings.name]!,
        );
      },
    );
  }
}
