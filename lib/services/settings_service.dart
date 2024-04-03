import 'package:legalz_hub_app/models/https/contact_list_upload.dart';
import 'package:legalz_hub_app/models/https/forgot_password_request.dart';
import 'package:legalz_hub_app/models/https/update_password_request.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/mixins.dart';
import 'package:legalz_hub_app/utils/repository/http_repository.dart';
import 'package:legalz_hub_app/utils/repository/method_name_constractor.dart';

class SettingService with Service {
  Future<void> uploadContactList({required UploadContact contacts}) async {
    await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.uploadContactList,
      postBody: contacts,
    );
  }

  Future<dynamic> forgotPassword({required ForgotPasswordRequest data}) async {
    final response = await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.forgotPassword,
      postBody: data,
    );
    return response;
  }

  Future<dynamic> changePassword(
      {required UpdatePasswordRequest account}) async {
    final response = await repository.callRequest(
      requestType: RequestType.put,
      methodName: MethodNameConstant.changePassword,
      postBody: account,
    );
    return response;
  }

  Future<dynamic> removeAccount(UserType userType) async {
    final response = await repository.callRequest(
      requestType: RequestType.delete,
      methodName: MethodNameConstant.deleteAccount,
      queryParam: {
        "userType": userType == UserType.attorney ? "attorney" : "customer"
      },
    );
    return response;
  }
}
