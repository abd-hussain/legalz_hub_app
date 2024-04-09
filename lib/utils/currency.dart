import 'package:hive_flutter/hive_flutter.dart';
import 'constants/database_constant.dart';

enum Timing { hour, threeQuarter, halfHour, quarterHour }

class Currency {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  String calculateHourRate(
      double hourRate, Timing timing, String currency, bool freeCall) {
    switch (timing) {
      case Timing.hour:
        return "${hourRate.toStringAsFixed(2)} $currency";
      case Timing.threeQuarter:
        return "${(hourRate - (hourRate / 4)).toStringAsFixed(2)} $currency";
      case Timing.halfHour:
        return "${(hourRate / 2).toStringAsFixed(2)} $currency";
      case Timing.quarterHour:
        if (freeCall) {
          return "0.0 $currency";
        } else {
          return "${(hourRate / 4).toStringAsFixed(2)} $currency";
        }
    }
  }

  String getHourRateWithoutCurrency(String hourRate) {
    String currency = "\$";
    return hourRate.replaceAll(currency, "");
  }
}
