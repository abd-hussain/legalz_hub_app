import 'dart:io';

import 'package:dio/dio.dart';
import 'package:legalz_hub_app/models/https/account_exp_model.dart';
import 'package:legalz_hub_app/models/https/update_attorney_account_request.dart';
import 'package:legalz_hub_app/utils/mixins.dart';
import 'package:legalz_hub_app/utils/repository/http_repository.dart';
import 'package:legalz_hub_app/utils/repository/method_name_constractor.dart';

class AttorneyAccountExperianceService with Service {
  Future<AccountExperiance> getProfileExperiance() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.accountExperiance,
    );
    return AccountExperiance.fromJson(response);
  }

  Future<dynamic> updateProfileExperiance(
      {required UpdateAccountExperianceRequest account}) async {
    String cvFileName = "";
    String cert1FileName = "";
    String cert2FileName = "";
    String cert3FileName = "";

    if (account.cv != null) {
      cvFileName = account.cv!.path.split('/').last;
    }
    if (account.cert1 != null) {
      cert1FileName = account.cert1!.path.split('/').last;
    }
    if (account.cert2 != null) {
      cert2FileName = account.cert2!.path.split('/').last;
    }
    if (account.cert3 != null) {
      cert3FileName = account.cert3!.path.split('/').last;
    }
    final FormData formData = FormData.fromMap({
      "cv": account.cv != null && account.cv != File("")
          ? await MultipartFile.fromFile(account.cv!.path, filename: cvFileName)
          : MultipartFile.fromString(""),
      "cert1": account.cert1 != null && account.cert1 != File("")
          ? await MultipartFile.fromFile(account.cert1!.path,
              filename: cert1FileName)
          : MultipartFile.fromString(""),
      "cert2": account.cert2 != null && account.cert2 != File("")
          ? await MultipartFile.fromFile(account.cert2!.path,
              filename: cert2FileName)
          : MultipartFile.fromString(""),
      "cert3": account.cert3 != null && account.cert3 != File("")
          ? await MultipartFile.fromFile(account.cert3!.path,
              filename: cert3FileName)
          : MultipartFile.fromString(""),
      "experience_since":
          MultipartFile.fromString(account.experienceSince ?? ""),
      "category_id": MultipartFile.fromString(account.categoryId!.toString()),
    });

    final response = await repository.callRequest(
      requestType: RequestType.put,
      methodName: MethodNameConstant.accountExperiance,
      formData: formData,
    );
    return response;
  }
}
