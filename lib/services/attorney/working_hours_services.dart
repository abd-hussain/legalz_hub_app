import 'package:legalz_hub_app/models/https/working_hour_request.dart';
import 'package:legalz_hub_app/models/https/working_hours.dart';
import 'package:legalz_hub_app/utils/mixins.dart';
import 'package:legalz_hub_app/utils/repository/http_repository.dart';
import 'package:legalz_hub_app/utils/repository/method_name_constractor.dart';

class WorkingHoursService with Service {
  Future<WorkingHours> getWorkingHours() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.attorneyWorkingHours,
    );

    return WorkingHours.fromJson(response);
  }

  Future<dynamic> updateWorkingHours(
      {required WorkingHoursRequest data}) async {
    final response = await repository.callRequest(
      requestType: RequestType.put,
      methodName: MethodNameConstant.attorneyWorkingHours,
      postBody: data,
    );

    return response;
  }
}
