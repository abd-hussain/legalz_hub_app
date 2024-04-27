import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:legalz_hub_app/models/https/customer_register_model.dart';
import 'package:legalz_hub_app/utils/mixins.dart';
import 'package:legalz_hub_app/utils/repository/http_repository.dart';
import 'package:legalz_hub_app/utils/repository/method_name_constractor.dart';

class CustomerRegisterService with Service {
  Future<dynamic> callRegister({required CustomerRegister data}) async {
    final FormData formData = FormData();

    formData.fields.add(MapEntry("first_name", data.firstName));
    formData.fields.add(MapEntry("last_name", data.lastName));
    formData.fields.add(MapEntry("date_of_birth", data.dateOfBirth));
    formData.fields.add(MapEntry("gender", data.gender.toString()));

    formData.fields.add(MapEntry("email", data.email));
    formData.fields.add(MapEntry("password", data.password));
    formData.fields.add(MapEntry("mobile_number", data.mobileNumber));

    if (data.pushToken != "" && data.pushToken != null) {
      formData.fields.add(MapEntry("push_token", data.pushToken!));
    }

    formData.fields.add(MapEntry("app_version", data.appVersion));

    formData.fields.add(MapEntry("country_id", data.countryId));

    if (data.referalCode != "" && data.referalCode != null) {
      formData.fields.add(MapEntry("referral_code", data.referalCode ?? ""));
    }

    if (data.profileImg != null) {
      final String fileName = data.profileImg!.split('/').last;
      formData.files.add(
        MapEntry(
          "profile_img",
          MultipartFile.fromFileSync(
            data.profileImg!,
            filename: fileName,
            contentType: MediaType('image', fileName.split('.').last),
          ),
        ),
      );
    }

    return repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.customerRegister,
      formData: formData,
    );
  }
}
