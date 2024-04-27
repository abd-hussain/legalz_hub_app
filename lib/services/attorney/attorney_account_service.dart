import 'package:dio/dio.dart';
import 'package:legalz_hub_app/models/https/attorney_account_info_model.dart';
import 'package:legalz_hub_app/models/https/update_attorney_account_request.dart';
import 'package:legalz_hub_app/utils/mixins.dart';
import 'package:legalz_hub_app/utils/repository/http_repository.dart';
import 'package:legalz_hub_app/utils/repository/method_name_constractor.dart';

class AttorneyAccountService with Service {
  Future<AttorneyAccountInfo> getProfileInfo() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.accountInfo,
    );
    return AttorneyAccountInfo.fromJson(response);
  }

  Future<AttorneyAccountInfo> updateProfileInfo(
      {required UpdateAttorneyAccountRequest account}) async {
    final FormData formData = FormData();
    formData.fields.add(MapEntry("suffixe_name", account.suffix));
    formData.fields.add(MapEntry("first_name", account.firstName));
    formData.fields.add(MapEntry("last_name", account.lastName));
    formData.fields.add(MapEntry("bio", account.bio));
    formData.fields.add(MapEntry("date_of_birth", account.dateOfBirth));
    formData.fields.add(MapEntry("country_id", account.countryId.toString()));
    formData.fields.add(MapEntry("gender", account.gender.toString()));

    for (final x1 in account.speackingLanguage) {
      formData.fields.add(MapEntry("speaking_language", x1));
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

    if (account.iDImage != null) {
      formData.files.add(
        MapEntry(
          "id_image",
          MultipartFile.fromFileSync(
            account.iDImage!.path,
            filename: account.iDImage!.path.split('/').last,
          ),
        ),
      );
    }

    final response = await repository.callRequest(
      requestType: RequestType.put,
      methodName: MethodNameConstant.accountInfo,
      formData: formData,
    );

    return AttorneyAccountInfo.fromJson(response);
  }
}
