import 'package:intl/intl.dart';
import 'package:legalz_hub_app/models/working_hours.dart';

class DayTime {
  String gettheCorrentImageDependOnCurrentTime() {
    final currentTime = DateTime.now();
    if (currentTime.hour > 8 && currentTime.hour < 18) {
      return "assets/images/days/sun.png";
    }
    return "assets/images/days/moon.png";
  }

  String dateFormatter(String dateAsString) {
    var parsedDate = DateTime.parse(dateAsString);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(parsedDate);
  }

  String convertingTimingToRealTime(int time) {
    if (time > 0 && time <= 9) {
      return "0$time:00 am";
    } else if (time > 9 && time <= 12) {
      return "$time:00 am";
    } else {
      return "${time - 12}:00 pm";
    }
  }

  String convertingTimingWithMinToRealTime(int hour, int min) {
    if (hour == 0) {
      return "12:${_minFraction(min)} am";
    } else if (hour > 0 && hour <= 9) {
      return "0$hour:${_minFraction(min)} am";
    } else if (hour > 9 && hour <= 12) {
      return "$hour:${_minFraction(min)} am";
    } else {
      return "${hour - 12}:${_minFraction(min)} pm";
    }
  }

  String _minFraction(int min) {
    if (min >= 0 && min <= 9) {
      return "0$min";
    } else {
      return "$min";
    }
  }

  List<WorkingHourUTCModel> prepareTimingToUTC(
      {required List<int> workingHoursSaturday,
      required List<int> workingHoursSunday,
      required List<int> workingHoursMonday,
      required List<int> workingHoursTuesday,
      required List<int> workingHoursWednesday,
      required List<int> workingHoursThursday,
      required List<int> workingHoursFriday}) {
    int offset = DateTime.now().timeZoneOffset.inHours;
    List<WorkingHourUTCModel> returnedList = [];

    // Map of working hours for each day
    var workingHoursMap = {
      DayNameEnum.saturday: workingHoursSaturday,
      DayNameEnum.sunday: workingHoursSunday,
      DayNameEnum.monday: workingHoursMonday,
      DayNameEnum.tuesday: workingHoursTuesday,
      DayNameEnum.wednesday: workingHoursWednesday,
      DayNameEnum.thursday: workingHoursThursday,
      DayNameEnum.friday: workingHoursFriday,
    };

    DayNameEnum previousDay =
        DayNameEnum.friday; // Start with Friday as the previous day of Saturday

    for (var entry in workingHoursMap.entries) {
      var day = entry.key;
      var hours = entry.value;
      var previousDayHours = <int>[];

      if (hours.isEmpty) {
        returnedList.add(WorkingHourUTCModel(dayName: day, list: []));
      } else {
        var editedWorkingHour = <int>[];
        for (var hour in hours) {
          var editedHour = hour - offset;
          if (editedHour < 0) {
            previousDayHours.add(24 + editedHour);
          } else {
            editedWorkingHour.add(editedHour);
          }
        }
        returnedList
            .add(WorkingHourUTCModel(dayName: day, list: editedWorkingHour));
      }

      // Add hours to the previous day if needed
      if (previousDayHours.isNotEmpty) {
        var previousDayModel = returnedList.firstWhere(
          (element) => element.dayName == previousDay,
          orElse: () => WorkingHourUTCModel(dayName: previousDay, list: []),
        );
        previousDayModel.list.addAll(previousDayHours);
      }

      previousDay = day; // Update the previous day
    }

    return returnedList;
  }

  List<WorkingHourUTCModel> prepareTimingFromUTC(
      {required List<int> workingHoursSaturday,
      required List<int> workingHoursSunday,
      required List<int> workingHoursMonday,
      required List<int> workingHoursTuesday,
      required List<int> workingHoursWednesday,
      required List<int> workingHoursThursday,
      required List<int> workingHoursFriday}) {
    int offset = DateTime.now().timeZoneOffset.inHours;
    List<WorkingHourUTCModel> returnedList = [
      WorkingHourUTCModel(dayName: DayNameEnum.saturday, list: []),
      WorkingHourUTCModel(dayName: DayNameEnum.sunday, list: []),
      WorkingHourUTCModel(dayName: DayNameEnum.monday, list: []),
      WorkingHourUTCModel(dayName: DayNameEnum.tuesday, list: []),
      WorkingHourUTCModel(dayName: DayNameEnum.wednesday, list: []),
      WorkingHourUTCModel(dayName: DayNameEnum.thursday, list: []),
      WorkingHourUTCModel(dayName: DayNameEnum.friday, list: []),
    ];

    // Map of working hours for each day
    var workingHoursMap = {
      DayNameEnum.saturday: workingHoursSaturday,
      DayNameEnum.sunday: workingHoursSunday,
      DayNameEnum.monday: workingHoursMonday,
      DayNameEnum.tuesday: workingHoursTuesday,
      DayNameEnum.wednesday: workingHoursWednesday,
      DayNameEnum.thursday: workingHoursThursday,
      DayNameEnum.friday: workingHoursFriday,
    };

    DayNameEnum nextDay =
        DayNameEnum.sunday; // Start with sunday as the after day of Saturday

    for (var entry in workingHoursMap.entries) {
      var day = entry.key;
      var hours = entry.value;
      var nextDayHours = <int>[];

      if (hours.isNotEmpty) {
        var editedWorkingHour = <int>[];
        for (var hour in hours) {
          var editedHour = hour + offset;
          if (editedHour >= 24) {
            nextDayHours.add(editedHour - 24);
          } else {
            editedWorkingHour.add(editedHour);
          }
        }
        returnedList
            .firstWhere((element) => element.dayName == day)
            .list
            .addAll(editedWorkingHour);
      }

      // Add hours to the next day if needed
      if (nextDayHours.isNotEmpty) {
        var nextDayModel = returnedList.firstWhere(
          (element) => element.dayName == getNextDay(nextDay),
          orElse: () =>
              WorkingHourUTCModel(dayName: getNextDay(nextDay), list: []),
        );
        nextDayModel.list.addAll(nextDayHours);
      }

      nextDay = getNextDay(day); // Update the next day
    }

    return returnedList;
  }

  DayNameEnum getNextDay(DayNameEnum day) {
    switch (day) {
      case DayNameEnum.saturday:
        return DayNameEnum.sunday;
      case DayNameEnum.sunday:
        return DayNameEnum.monday;
      case DayNameEnum.monday:
        return DayNameEnum.tuesday;
      case DayNameEnum.tuesday:
        return DayNameEnum.wednesday;
      case DayNameEnum.wednesday:
        return DayNameEnum.thursday;
      case DayNameEnum.thursday:
        return DayNameEnum.thursday;
      case DayNameEnum.friday:
        return DayNameEnum.saturday;
    }
  }

  int getHourFromTimeString(String time) {
    if (time.contains("a.m")) {
      String result = time.replaceAll(" a.m", "");
      var parts = result.split(':');
      return int.parse(parts[0].trim());
    } else {
      String result = time.replaceAll(" p.m", "");
      var parts = result.split(':');
      return _getHourPm(int.parse(parts[0].trim()));
    }
  }

  int _getHourPm(int hour) {
    if (hour == 1) {
      return 13;
    } else if (hour == 2) {
      return 14;
    } else if (hour == 2) {
      return 14;
    } else if (hour == 3) {
      return 15;
    } else if (hour == 4) {
      return 16;
    } else if (hour == 5) {
      return 17;
    } else if (hour == 6) {
      return 18;
    } else if (hour == 7) {
      return 19;
    } else if (hour == 8) {
      return 20;
    } else if (hour == 9) {
      return 21;
    } else if (hour == 10) {
      return 22;
    } else if (hour == 11) {
      return 23;
    } else {
      return 0;
    }
  }

  String convertDayToArabic(String dayName) {
    switch (dayName) {
      case "Saturday":
        return "السبت";
      case "Sunday":
        return "الاحد";
      case "Monday":
        return "الاثنين";
      case "Tuesday":
        return "الثلاثاء";
      case "Wednesday":
        return "الاربعاء";
      case "Thursday":
        return "الخميس";
      case "Friday":
        return "الجمعة";
      default:
        return "";
    }
  }
}
