import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:legalz_hub_app/models/https/register_model.dart';
import 'package:legalz_hub_app/utils/mixins.dart';
import 'package:legalz_hub_app/utils/repository/http_repository.dart';
import 'package:legalz_hub_app/utils/repository/method_name_constractor.dart';

class RegisterService with Service {
  Future<dynamic> callRegister({required Register data}) async {
    FormData formData = FormData();

    formData.fields.add(MapEntry("suffixe_name", data.suffixeName));
    formData.fields.add(MapEntry("first_name", data.firstName));
    formData.fields.add(MapEntry("last_name", data.lastName));
    formData.fields.add(MapEntry("gender", data.gender.toString()));
    formData.fields.add(MapEntry("password", data.password));
    formData.fields.add(MapEntry("date_of_birth", data.dateOfBirth));
    formData.fields.add(MapEntry("bio", data.bio));
    formData.fields.add(MapEntry("mobile_number", data.mobileNumber));
    formData.fields.add(MapEntry("email", data.email));

    if (data.pushToken != "" && data.pushToken != null) {
      formData.fields.add(MapEntry("push_token", data.pushToken!));
    }

    if (data.referalCode != "" && data.referalCode != null) {
      formData.fields.add(MapEntry("referral_code", data.referalCode ?? ""));
    }

    formData.fields.add(MapEntry("app_version", data.appVersion));
    formData.fields.add(MapEntry("experience_since", data.experienceSince));
    formData.fields.add(MapEntry("category_id", data.categoryId));
    formData.fields.add(MapEntry("hour_rate", data.hourRate));
    formData.fields.add(MapEntry("iban", data.iban));
    formData.fields.add(MapEntry("country_id", data.countryId));

    for (var x1 in data.majors) {
      formData.fields.add(MapEntry("majors", x1.toString()));
    }

    if (data.workingHoursSaturday != null) {
      for (var x1 in data.workingHoursSaturday!) {
        formData.fields.add(MapEntry("working_hours_saturday", x1.toString()));
      }
    }

    if (data.workingHoursSunday != null) {
      for (var x1 in data.workingHoursSunday!) {
        formData.fields.add(MapEntry("working_hours_sunday", x1.toString()));
      }
    }

    if (data.workingHoursMonday != null) {
      for (var x1 in data.workingHoursMonday!) {
        formData.fields.add(MapEntry("working_hours_monday", x1.toString()));
      }
    }

    if (data.workingHoursTuesday != null) {
      for (var x1 in data.workingHoursTuesday!) {
        formData.fields.add(MapEntry("working_hours_tuesday", x1.toString()));
      }
    }

    if (data.workingHoursWednesday != null) {
      for (var x1 in data.workingHoursWednesday!) {
        formData.fields.add(MapEntry("working_hours_wednesday", x1.toString()));
      }
    }

    if (data.workingHoursThursday != null) {
      for (var x1 in data.workingHoursThursday!) {
        formData.fields.add(MapEntry("working_hours_thursday", x1.toString()));
      }
    }

    if (data.workingHoursFriday != null) {
      for (var x1 in data.workingHoursFriday!) {
        formData.fields.add(MapEntry("working_hours_friday", x1.toString()));
      }
    }

    for (var x1 in data.speakingLanguage) {
      formData.fields.add(MapEntry("speaking_language", x1.toString()));
    }

    if (data.profileImg != null) {
      String fileName = data.profileImg!.split('/').last;
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

    if (data.idImg != null) {
      String fileName = data.idImg!.split('/').last;
      formData.files.add(
        MapEntry(
          "id_img",
          MultipartFile.fromFileSync(
            data.idImg!,
            filename: fileName,
            contentType: MediaType('image', fileName.split('.').last),
          ),
        ),
      );
    }

    if (data.cv != null) {
      String fileName = data.cv!.split('/').last;
      formData.files.add(
        MapEntry(
          "cv",
          MultipartFile.fromFileSync(
            data.cv!,
            filename: fileName,
          ),
        ),
      );
    }

    if (data.cert1 != null) {
      String fileName = data.cert1!.split('/').last;

      formData.files.add(
        MapEntry(
          "cert1",
          MultipartFile.fromFileSync(
            data.cert1!,
            filename: fileName,
          ),
        ),
      );
    }

    if (data.cert2 != null && data.cert2 != "") {
      String fileName = data.cert2!.split('/').last;

      formData.files.add(
        MapEntry(
          "cert2",
          MultipartFile.fromFileSync(
            data.cert2!,
            filename: fileName,
          ),
        ),
      );
    }

    if (data.cert3 != null && data.cert3 != "") {
      String fileName = data.cert3!.split('/').last;

      formData.files.add(
        MapEntry(
          "cert3",
          MultipartFile.fromFileSync(
            data.cert3!,
            filename: fileName,
          ),
        ),
      );
    }

    return repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.register,
      formData: formData,
    );
  }
}
