enum DayNameEnum {
  saturday,
  sunday,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday
}

class WorkingHourModel {
  List<CheckBox> list;
  String dayName;

  WorkingHourModel({required this.list, required this.dayName});
}

class CheckBox {
  final int? id;
  final String value;
  bool isEnable;

  CheckBox({this.id, required this.value, required this.isEnable});
}

class WorkingHourUTCModel {
  List<int> list;
  DayNameEnum dayName;

  WorkingHourUTCModel({required this.list, required this.dayName});
}
