import 'package:legalz_hub_app/models/https/home_response.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/mixins.dart';
import 'package:legalz_hub_app/utils/repository/http_repository.dart';
import 'package:legalz_hub_app/utils/repository/method_name_constractor.dart';

class HomeService with Service {
  Future<HomeResponse> getHome(UserType userType) async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.home,
      queryParam: {"userType": userType == UserType.attorney ? "attorney" : "customer"},
    );
    return HomeResponse.fromJson(response);
  }
}
