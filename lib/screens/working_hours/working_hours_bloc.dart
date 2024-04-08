import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/models/https/working_hour_request.dart';
import 'package:legalz_hub_app/models/https/working_hours.dart';
import 'package:legalz_hub_app/models/working_hours.dart';
import 'package:legalz_hub_app/services/attorney/working_hours_services.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/day_time.dart';
import 'package:legalz_hub_app/utils/enums/loading_status.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/utils/mixins.dart';

class WorkingHoursBloc extends Bloc<WorkingHoursService> {
  ValueNotifier<LoadingStatus> loadingStatusNotifier =
      ValueNotifier<LoadingStatus>(LoadingStatus.idle);
  ValueNotifier<List<WorkingHourModel>> listOfWorkingHourNotifier =
      ValueNotifier<List<WorkingHourModel>>([]);
  var box = Hive.box(DatabaseBoxConstant.userInfo);

  List<CheckBox> _prepareList(
      {required BuildContext context, required List<int> theList}) {
    List<CheckBox> list = [];

    list.add(CheckBox(
        value: "1:00 ${AppLocalizations.of(context)!.pm}",
        isEnable: theList.contains(1)));
    list.add(CheckBox(
        value: "2:00 ${AppLocalizations.of(context)!.pm}",
        isEnable: theList.contains(2)));
    list.add(CheckBox(
        value: "3:00 ${AppLocalizations.of(context)!.pm}",
        isEnable: theList.contains(3)));
    list.add(CheckBox(
        value: "4:00 ${AppLocalizations.of(context)!.pm}",
        isEnable: theList.contains(4)));
    list.add(CheckBox(
        value: "5:00 ${AppLocalizations.of(context)!.pm}",
        isEnable: theList.contains(5)));
    list.add(CheckBox(
        value: "6:00 ${AppLocalizations.of(context)!.pm}",
        isEnable: theList.contains(6)));
    list.add(CheckBox(
        value: "7:00 ${AppLocalizations.of(context)!.pm}",
        isEnable: theList.contains(7)));
    list.add(CheckBox(
        value: "8:00 ${AppLocalizations.of(context)!.pm}",
        isEnable: theList.contains(8)));
    list.add(CheckBox(
        value: "9:00 ${AppLocalizations.of(context)!.pm}",
        isEnable: theList.contains(9)));
    list.add(CheckBox(
        value: "10:00 ${AppLocalizations.of(context)!.pm}",
        isEnable: theList.contains(10)));
    list.add(CheckBox(
        value: "11:00 ${AppLocalizations.of(context)!.pm}",
        isEnable: theList.contains(11)));
    list.add(CheckBox(
        value: "12:00 ${AppLocalizations.of(context)!.pm}",
        isEnable: theList.contains(12)));
    list.add(CheckBox(
        value: "1:00 ${AppLocalizations.of(context)!.am}",
        isEnable: theList.contains(13)));
    list.add(CheckBox(
        value: "2:00 ${AppLocalizations.of(context)!.am}",
        isEnable: theList.contains(14)));
    list.add(CheckBox(
        value: "3:00 ${AppLocalizations.of(context)!.am}",
        isEnable: theList.contains(15)));
    list.add(CheckBox(
        value: "4:00 ${AppLocalizations.of(context)!.am}",
        isEnable: theList.contains(16)));
    list.add(CheckBox(
        value: "5:00 ${AppLocalizations.of(context)!.am}",
        isEnable: theList.contains(17)));
    list.add(CheckBox(
        value: "6:00 ${AppLocalizations.of(context)!.am}",
        isEnable: theList.contains(18)));
    list.add(CheckBox(
        value: "7:00 ${AppLocalizations.of(context)!.am}",
        isEnable: theList.contains(19)));
    list.add(CheckBox(
        value: "8:00 ${AppLocalizations.of(context)!.am}",
        isEnable: theList.contains(20)));
    list.add(CheckBox(
        value: "9:00 ${AppLocalizations.of(context)!.am}",
        isEnable: theList.contains(21)));
    list.add(CheckBox(
        value: "10:00 ${AppLocalizations.of(context)!.am}",
        isEnable: theList.contains(22)));
    list.add(CheckBox(
        value: "11:00 ${AppLocalizations.of(context)!.am}",
        isEnable: theList.contains(23)));
    list.add(CheckBox(
        value: "12:00 ${AppLocalizations.of(context)!.am}",
        isEnable: theList.contains(0)));

    return list;
  }

  WorkingHoursData formatDataFromUTCToLocalTime(WorkingHoursData data) {
    final newData = DayTime().prepareTimingFromUTC(
        workingHoursSaturday: data.workingHoursSaturday ?? [],
        workingHoursSunday: data.workingHoursSunday ?? [],
        workingHoursMonday: data.workingHoursMonday ?? [],
        workingHoursTuesday: data.workingHoursTuesday ?? [],
        workingHoursWednesday: data.workingHoursWednesday ?? [],
        workingHoursThursday: data.workingHoursThursday ?? [],
        workingHoursFriday: data.workingHoursFriday ?? []);

    return WorkingHoursData(
      workingHoursSaturday: newData
          .where((element) => element.dayName == DayNameEnum.saturday)
          .first
          .list,
      workingHoursSunday: newData
          .where((element) => element.dayName == DayNameEnum.sunday)
          .first
          .list,
      workingHoursMonday: newData
          .where((element) => element.dayName == DayNameEnum.monday)
          .first
          .list,
      workingHoursTuesday: newData
          .where((element) => element.dayName == DayNameEnum.tuesday)
          .first
          .list,
      workingHoursWednesday: newData
          .where((element) => element.dayName == DayNameEnum.wednesday)
          .first
          .list,
      workingHoursThursday: newData
          .where((element) => element.dayName == DayNameEnum.thursday)
          .first
          .list,
      workingHoursFriday: newData
          .where((element) => element.dayName == DayNameEnum.friday)
          .first
          .list,
    );
  }

  void getWorkingHours(BuildContext context) {
    loadingStatusNotifier.value = LoadingStatus.inprogress;

    service.getWorkingHours().then((value) {
      loadingStatusNotifier.value = LoadingStatus.finish;
      if (value.data != null) {
        WorkingHoursData formatedData =
            formatDataFromUTCToLocalTime(value.data!);
        List<WorkingHourModel> theList = [];
        if (formatedData.workingHoursSaturday != null) {
          theList.add(WorkingHourModel(
              list: _prepareList(
                  context: context,
                  theList: formatedData.workingHoursSaturday!),
              dayName: "Saturday"));
        }
        if (formatedData.workingHoursSunday != null) {
          theList.add(WorkingHourModel(
              list: _prepareList(
                  context: context, theList: formatedData.workingHoursSunday!),
              dayName: "Sunday"));
        }
        if (formatedData.workingHoursMonday != null) {
          theList.add(WorkingHourModel(
              list: _prepareList(
                  context: context, theList: formatedData.workingHoursMonday!),
              dayName: "Monday"));
        }
        if (formatedData.workingHoursTuesday != null) {
          theList.add(WorkingHourModel(
              list: _prepareList(
                  context: context, theList: formatedData.workingHoursTuesday!),
              dayName: "Tuesday"));
        }
        if (formatedData.workingHoursWednesday != null) {
          theList.add(WorkingHourModel(
              list: _prepareList(
                  context: context,
                  theList: formatedData.workingHoursWednesday!),
              dayName: "Wednesday"));
        }
        if (formatedData.workingHoursThursday != null) {
          theList.add(WorkingHourModel(
              list: _prepareList(
                  context: context,
                  theList: formatedData.workingHoursThursday!),
              dayName: "Thursday"));
        }
        if (formatedData.workingHoursFriday != null) {
          theList.add(WorkingHourModel(
              list: _prepareList(
                  context: context, theList: formatedData.workingHoursFriday!),
              dayName: "Friday"));
        }

        listOfWorkingHourNotifier.value = theList;
      }
    });
  }

  Future<void> updateWorkingHours(
      {required BuildContext context, required WorkingHoursRequest obj}) async {
    loadingStatusNotifier.value = LoadingStatus.inprogress;

    List<int> workingHoursSaturday = [];
    List<int> workingHoursSunday = [];
    List<int> workingHoursMonday = [];
    List<int> workingHoursTuesday = [];
    List<int> workingHoursWednesday = [];
    List<int> workingHoursThursday = [];
    List<int> workingHoursFriday = [];

    if (obj.dayName == "Saturday") {
      workingHoursSaturday = obj.workingHours;
    } else if (obj.dayName == "Sunday") {
      workingHoursSunday = obj.workingHours;
    } else if (obj.dayName == "Monday") {
      workingHoursMonday = obj.workingHours;
    } else if (obj.dayName == "Tuesday") {
      workingHoursTuesday = obj.workingHours;
    } else if (obj.dayName == "Wednesday") {
      workingHoursWednesday = obj.workingHours;
    } else if (obj.dayName == "Thursday") {
      workingHoursThursday = obj.workingHours;
    } else if (obj.dayName == "Friday") {
      workingHoursFriday = obj.workingHours;
    }

    final newData = DayTime().prepareTimingToUTC(
        workingHoursSaturday: workingHoursSaturday,
        workingHoursSunday: workingHoursSunday,
        workingHoursMonday: workingHoursMonday,
        workingHoursTuesday: workingHoursTuesday,
        workingHoursWednesday: workingHoursWednesday,
        workingHoursThursday: workingHoursThursday,
        workingHoursFriday: workingHoursFriday);

    for (var item in newData) {
      if (item.list.isNotEmpty) {
        WorkingHoursRequest newObj = WorkingHoursRequest(
            dayName: dayParser(item.dayName), workingHours: item.list);
        await service.updateWorkingHours(data: newObj);
      }
    }
  }

  String dayParser(DayNameEnum dayName) {
    switch (dayName) {
      case DayNameEnum.saturday:
        return "Saturday";
      case DayNameEnum.sunday:
        return "Sunday";
      case DayNameEnum.monday:
        return "Monday";
      case DayNameEnum.tuesday:
        return "Tuesday";
      case DayNameEnum.wednesday:
        return "Wednesday";
      case DayNameEnum.thursday:
        return "Thursday";
      case DayNameEnum.friday:
        return "Friday";
    }
  }

  @override
  onDispose() {
    loadingStatusNotifier.dispose();
    listOfWorkingHourNotifier.dispose();
  }
}
