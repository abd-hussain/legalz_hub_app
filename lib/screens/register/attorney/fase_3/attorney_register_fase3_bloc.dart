import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/models/working_hours.dart';
import 'package:legalz_hub_app/services/filter_services.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/day_time.dart';
import 'package:legalz_hub_app/utils/mixins.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AttorneyRegister3Bloc extends Bloc<FilterService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  ValueNotifier<List<WorkingHourModel>> listOfWorkingHourNotifier =
      ValueNotifier<List<WorkingHourModel>>([]);
  ValueNotifier<bool> enableNextBtn = ValueNotifier<bool>(false);

  tryToFillTheFields(BuildContext context) {
    if (box.get(TempFieldToRegistrtAttorneyConstant.saturdayWH) != null) {
      listOfWorkingHourNotifier.value
              .firstWhere((element) =>
                  element.dayName == AppLocalizations.of(context)!.saturday)
              .list =
          prepareList(
              context, box.get(TempFieldToRegistrtAttorneyConstant.saturdayWH));
    }
    if (box.get(TempFieldToRegistrtAttorneyConstant.sundayWH) != null) {
      listOfWorkingHourNotifier.value
              .firstWhere((element) =>
                  element.dayName == AppLocalizations.of(context)!.sunday)
              .list =
          prepareList(
              context, box.get(TempFieldToRegistrtAttorneyConstant.sundayWH));
    }
    if (box.get(TempFieldToRegistrtAttorneyConstant.mondayWH) != null) {
      listOfWorkingHourNotifier.value
              .firstWhere((element) =>
                  element.dayName == AppLocalizations.of(context)!.monday)
              .list =
          prepareList(
              context, box.get(TempFieldToRegistrtAttorneyConstant.mondayWH));
    }
    if (box.get(TempFieldToRegistrtAttorneyConstant.tuesdayWH) != null) {
      listOfWorkingHourNotifier.value
              .firstWhere((element) =>
                  element.dayName == AppLocalizations.of(context)!.tuesday)
              .list =
          prepareList(
              context, box.get(TempFieldToRegistrtAttorneyConstant.tuesdayWH));
    }
    if (box.get(TempFieldToRegistrtAttorneyConstant.wednesdayWH) != null) {
      listOfWorkingHourNotifier.value
              .firstWhere((element) =>
                  element.dayName == AppLocalizations.of(context)!.wednesday)
              .list =
          prepareList(context,
              box.get(TempFieldToRegistrtAttorneyConstant.wednesdayWH));
    }
    if (box.get(TempFieldToRegistrtAttorneyConstant.thursdayWH) != null) {
      listOfWorkingHourNotifier.value
              .firstWhere((element) =>
                  element.dayName == AppLocalizations.of(context)!.thursday)
              .list =
          prepareList(
              context, box.get(TempFieldToRegistrtAttorneyConstant.thursdayWH));
    }
    if (box.get(TempFieldToRegistrtAttorneyConstant.fridayWH) != null) {
      listOfWorkingHourNotifier.value
              .firstWhere((element) =>
                  element.dayName == AppLocalizations.of(context)!.friday)
              .list =
          prepareList(
              context, box.get(TempFieldToRegistrtAttorneyConstant.fridayWH));
    }

    validateFieldsForFaze3();
  }

  List<CheckBox> prepareList(BuildContext context, List<int> theList) {
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

  fillListOfWorkingHourNotifier(BuildContext context) {
    listOfWorkingHourNotifier.value = [];
    listOfWorkingHourNotifier.value.add(WorkingHourModel(
        list: prepareList(context, []),
        dayName: AppLocalizations.of(context)!.saturday));
    listOfWorkingHourNotifier.value.add(WorkingHourModel(
        list: prepareList(context, []),
        dayName: AppLocalizations.of(context)!.sunday));
    listOfWorkingHourNotifier.value.add(WorkingHourModel(
        list: prepareList(context, []),
        dayName: AppLocalizations.of(context)!.monday));
    listOfWorkingHourNotifier.value.add(WorkingHourModel(
        list: prepareList(context, []),
        dayName: AppLocalizations.of(context)!.tuesday));
    listOfWorkingHourNotifier.value.add(WorkingHourModel(
        list: prepareList(context, []),
        dayName: AppLocalizations.of(context)!.wednesday));
    listOfWorkingHourNotifier.value.add(WorkingHourModel(
        list: prepareList(context, []),
        dayName: AppLocalizations.of(context)!.thursday));
    listOfWorkingHourNotifier.value.add(WorkingHourModel(
        list: prepareList(context, []),
        dayName: AppLocalizations.of(context)!.friday));

    tryToFillTheFields(context);
  }

  validateFieldsForFaze3() {
    bool isButtonEnabled = false;

    for (var weekDay in listOfWorkingHourNotifier.value) {
      for (var items in weekDay.list) {
        if (items.isEnable) {
          isButtonEnabled = true;
          break;
        }
      }
    }

    enableNextBtn.value = isButtonEnabled;
  }

  List<int> filterListOfTiming({required String dayName}) {
    List<int> newList = [];

    List<WorkingHourModel> selectedList = listOfWorkingHourNotifier.value;

    for (var item in selectedList) {
      if (item.dayName == dayName) {
        for (var item2 in item.list) {
          if (item2.isEnable) {
            newList.add(DayTime().getHourFromTimeString(item2.value));
          }
        }
      }
    }
    return newList;
  }

  @override
  onDispose() {}
}
