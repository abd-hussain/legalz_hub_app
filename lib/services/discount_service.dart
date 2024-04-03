import 'package:legalz_hub_app/models/https/discount_model.dart';
import 'package:legalz_hub_app/utils/mixins.dart';
import 'package:legalz_hub_app/utils/repository/http_repository.dart';
import 'package:legalz_hub_app/utils/repository/method_name_constractor.dart';

class DiscountService with Service {
  Future<DiscountModel> discount(String code) async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      queryParam: {"code": code},
      methodName: MethodNameConstant.discount,
    );
    return DiscountModel.fromJson(response);
  }
}
