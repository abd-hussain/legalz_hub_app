import 'package:legalz_hub_app/models/https/attorney_details_model.dart';
import 'package:legalz_hub_app/models/https/attorney_info_avaliable_model.dart';
import 'package:legalz_hub_app/utils/mixins.dart';
import 'package:legalz_hub_app/utils/repository/http_repository.dart';
import 'package:legalz_hub_app/utils/repository/method_name_constractor.dart';

class AttorneyDetailsService with Service {
  Future<AttorneyDetailsResponse> attorneyDetails(int attorneyID) async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.attorneyDetails,
      queryParam: {"id": attorneyID},
    );

    return AttorneyDetailsResponse.fromJson(response);
  }

  Future<AttorneyInfoAvaliableResponse> getAttorneyAvaliable(
      {required int categoryID}) async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.attorneyListAvaliable,
      queryParam: {"catId": categoryID},
    );

    return AttorneyInfoAvaliableResponse.fromJson(response);
  }
}
