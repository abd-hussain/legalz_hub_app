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
  WorkingHourModel({required this.list, required this.dayName});
  List<CheckBox> list;
  String dayName;
}

class CheckBox {
  CheckBox({this.id, required this.value, required this.isEnable});
  final int? id;
  final String value;
  bool isEnable;
}

class WorkingHourUTCModel {
  WorkingHourUTCModel({required this.list, required this.dayName});
  List<int> list;
  DayNameEnum dayName;
}
