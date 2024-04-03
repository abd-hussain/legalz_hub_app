import 'package:dio/dio.dart';
import 'package:legalz_hub_app/models/https/customer_account_info_model.dart';
import 'package:legalz_hub_app/models/https/update_customer_account_request.dart';
import 'package:legalz_hub_app/utils/mixins.dart';
import 'package:legalz_hub_app/utils/repository/http_repository.dart';
import 'package:legalz_hub_app/utils/repository/method_name_constractor.dart';

class CustomerAccountService with Service {
  Future<CustomerAccountInfo> getCustomerAccountInfo() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.customerAccount,
    );
    return CustomerAccountInfo.fromJson(response);
  }

  Future<CustomerAccountInfo> updateAccount(
      {required UpdateCustomerAccountRequest account}) async {
    FormData formData = FormData();
    if (account.firstName != null) {
      formData.fields.add(MapEntry("first_name", account.firstName!));
    }
    if (account.lastName != null) {
      formData.fields.add(MapEntry("last_name", account.lastName!));
    }
    if (account.gender != null) {
      formData.fields.add(MapEntry("gender", account.gender.toString()));
    }
    if (account.countryId != null) {
      formData.fields.add(MapEntry("country_id", account.countryId.toString()));
    }
    if (account.referalCode != null) {
      formData.fields.add(MapEntry("referral_code", account.referalCode!));
    }
    if (account.email != null) {
      formData.fields.add(MapEntry("email", account.email!));
    }
    if (account.dateOfBirth != null) {
      formData.fields.add(MapEntry("date_of_birth", account.dateOfBirth!));
    }

    if (account.profileImage != null) {
      formData.files.add(
        MapEntry(
          "profile_img",
          MultipartFile.fromFileSync(
            account.profileImage!.path,
            filename: account.profileImage!.path.split('/').last,
          ),
        ),
      );
    }

    final response = await repository.callRequest(
        requestType: RequestType.put,
        methodName: MethodNameConstant.customerAccountUpdate,
        formData: formData);

    return CustomerAccountInfo.fromJson(response);
  }

  Future<dynamic> removeAccount() async {
    final response = await repository.callRequest(
      requestType: RequestType.delete,
      methodName: MethodNameConstant.deleteAccount,
    );
    return response;
  }
}
