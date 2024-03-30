class WorkingHours {
  WorkingHoursData? data;
  String? message;

  WorkingHours({this.data, this.message});

  WorkingHours.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? WorkingHoursData.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class WorkingHoursData {
  int? id;
  List<int>? workingHoursSaturday;
  List<int>? workingHoursSunday;
  List<int>? workingHoursMonday;
  List<int>? workingHoursTuesday;
  List<int>? workingHoursWednesday;
  List<int>? workingHoursThursday;
  List<int>? workingHoursFriday;

  WorkingHoursData(
      {this.id,
      this.workingHoursSaturday,
      this.workingHoursSunday,
      this.workingHoursMonday,
      this.workingHoursTuesday,
      this.workingHoursWednesday,
      this.workingHoursThursday,
      this.workingHoursFriday});

  WorkingHoursData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workingHoursSaturday = json['working_hours_saturday'].cast<int>();
    workingHoursSunday = json['working_hours_sunday'].cast<int>();
    workingHoursMonday = json['working_hours_monday'].cast<int>();
    workingHoursTuesday = json['working_hours_tuesday'].cast<int>();
    workingHoursWednesday = json['working_hours_wednesday'].cast<int>();
    workingHoursThursday = json['working_hours_thursday'].cast<int>();
    workingHoursFriday = json['working_hours_friday'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['working_hours_saturday'] = workingHoursSaturday;
    data['working_hours_sunday'] = workingHoursSunday;
    data['working_hours_monday'] = workingHoursMonday;
    data['working_hours_tuesday'] = workingHoursTuesday;
    data['working_hours_wednesday'] = workingHoursWednesday;
    data['working_hours_thursday'] = workingHoursThursday;
    data['working_hours_friday'] = workingHoursFriday;
    return data;
  }
}
