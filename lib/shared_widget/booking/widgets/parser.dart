import 'package:legalz_hub_app/utils/currency.dart';

class ParserTimer {
  String getTime(Timing time) {
    switch (time) {
      case Timing.hour:
        return "60";
      case Timing.threeQuarter:
        return "45";
      case Timing.halfHour:
        return "30";
      case Timing.quarterHour:
        return "15";
    }
  }

  String getHours(int time) {
    switch (time) {
      case 1:
        return "1:00 a.m";
      case 2:
        return "2:00 a.m";
      case 3:
        return "3:00 a.m";
      case 4:
        return "4:00 a.m";
      case 5:
        return "5:00 a.m";
      case 6:
        return "6:00 a.m";
      case 7:
        return "7:00 a.m";
      case 8:
        return "8:00 a.m";
      case 9:
        return "9:00 a.m";
      case 10:
        return "10:00 a.m";
      case 11:
        return "11:00 a.m";
      case 12:
        return "12:00 a.m";
      case 13:
        return "1:00 p.m";
      case 14:
        return "2:00 p.m";
      case 15:
        return "3:00 p.m";
      case 16:
        return "4:00 p.m";
      case 17:
        return "5:00 p.m";
      case 18:
        return "6:00 p.m";
      case 19:
        return "7:00 p.m";
      case 20:
        return "8:00 p.m";
      case 21:
        return "9:00 p.m";
      case 22:
        return "10:00 p.m";
      case 23:
        return "11:00 p.m";
      case 24:
        return "12:00 p.m";
      default:
        return "0:00 a.m";
    }
  }
}
