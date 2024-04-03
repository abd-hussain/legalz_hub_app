import 'package:legalz_hub_app/models/https/attorney_model.dart';
import 'package:legalz_hub_app/utils/mixins.dart';
import 'package:legalz_hub_app/utils/repository/http_repository.dart';
import 'package:legalz_hub_app/utils/repository/method_name_constractor.dart';

class AttorneyListService with Service {
  Future<AttorneyModel> attorneyUnderCategory(int categoryID) async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.attorneyList,
      queryParam: {"categories_id": categoryID},
    );

    return AttorneyModel.fromJson(response);
  }
}
