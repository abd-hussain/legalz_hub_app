import 'package:legalz_hub_app/utils/mixins.dart';

class WorkingHoursRequest implements Model {
  WorkingHoursRequest({required this.dayName, required this.workingHours});
  String dayName;
  List<int> workingHours;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['dayName'] = dayName;
    data['working_hours'] = workingHours;
    return data;
  }
}
