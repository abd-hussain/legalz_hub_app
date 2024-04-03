import 'package:legalz_hub_app/models/https/categories_model.dart';
import 'package:legalz_hub_app/models/https/countries_model.dart';
import 'package:legalz_hub_app/models/https/referal_code_request.dart';
import 'package:legalz_hub_app/models/https/suffix_model.dart';
import 'package:legalz_hub_app/utils/mixins.dart';
import 'package:legalz_hub_app/utils/repository/http_repository.dart';
import 'package:legalz_hub_app/utils/repository/method_name_constractor.dart';

class FilterService with Service {
  Future<CategoriesModel> categories() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.categories,
    );
    return CategoriesModel.fromJson(response);
  }

  Future<CountriesModel> countries() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.countries,
    );
    return CountriesModel.fromJson(response);
  }

  Future<Suffix> suffix() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.suffix,
    );
    return Suffix.fromJson(response);
  }

  Future<bool> validateEmailAddress(String email) async {
    final response = await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.checkEmail,
      queryParam: {"email": email},
    );
    return response["data"];
  }

  Future<bool> validateMobileNumber(String mobile) async {
    final response = await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.checkMobile,
      queryParam: {"mobile": mobile},
    );
    return response["data"];
  }

  Future<bool> validateReferalCode(String code) async {
    final response = await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.referalCode,
      queryParam: {"code": code},
      postBody: ReferalCodeRequest(code: code),
    );

    return response["data"];
  }

  Future<double> currencyConverter(String currency) async {
    final response = await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.currencyConverter,
      queryParam: {"currency": currency},
    );

    return response["data"];
  }
}
