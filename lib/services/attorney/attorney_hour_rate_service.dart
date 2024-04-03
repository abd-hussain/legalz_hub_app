import 'package:legalz_hub_app/models/https/hour_rate_response.dart';
import 'package:legalz_hub_app/utils/mixins.dart';
import 'package:legalz_hub_app/utils/repository/http_repository.dart';
import 'package:legalz_hub_app/utils/repository/method_name_constractor.dart';

class AttorneyHourRateService with Service {
  Future<HourRateResponse> getHourRateAndIban() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.attorneyHourRate,
    );

    return HourRateResponse.fromJson(response);
  }

  Future<dynamic> updateHourRate({
    required String newRate,
    required String iban,
    required int freeCall,
  }) async {
    final response = await repository.callRequest(
      requestType: RequestType.put,
      queryParam: {
        "hour_rate": newRate,
        "iban": iban,
        "free_type": freeCall,
      },
      methodName: MethodNameConstant.attorneyHourRate,
    );

    return response;
  }
}
