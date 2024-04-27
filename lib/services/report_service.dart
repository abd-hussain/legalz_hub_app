import 'package:dio/dio.dart';
import 'package:legalz_hub_app/models/https/report_request.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/mixins.dart';
import 'package:legalz_hub_app/utils/repository/http_repository.dart';
import 'package:legalz_hub_app/utils/repository/method_name_constractor.dart';

class ReportService with Service {
  Future<dynamic> addSuggestion({required ReportRequest reportData}) async {
    final FormData formData = FormData();
    formData.fields.add(MapEntry("content", reportData.content));

    switch (reportData.userType) {
      case UserType.attorney:
        formData.fields.add(MapEntry("attorney_user_id", reportData.userId));
      case UserType.customer:
        formData.fields.add(MapEntry("customer_user_id", reportData.userId));
    }

    if (reportData.attach1 != null) {
      final String fileName = reportData.attach1!.path.split('/').last;
      formData.files.add(
        MapEntry(
          "attach1",
          MultipartFile.fromFileSync(
            reportData.attach1!.path,
            filename: fileName,
          ),
        ),
      );
    }

    if (reportData.attach2 != null) {
      final String fileName = reportData.attach2!.path.split('/').last;
      formData.files.add(
        MapEntry(
          "attach2",
          MultipartFile.fromFileSync(
            reportData.attach2!.path,
            filename: fileName,
          ),
        ),
      );
    }
    if (reportData.attach3 != null) {
      final String fileName = reportData.attach3!.path.split('/').last;
      formData.files.add(
        MapEntry(
          "attach3",
          MultipartFile.fromFileSync(
            reportData.attach3!.path,
            filename: fileName,
          ),
        ),
      );
    }

    return repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.reportSuggestion,
      formData: formData,
    );
  }

  Future<dynamic> addBugIssue({required ReportRequest reportData}) async {
    final FormData formData = FormData();
    formData.fields.add(MapEntry("content", reportData.content));

    switch (reportData.userType) {
      case UserType.attorney:
        formData.fields.add(MapEntry("attorney_user_id", reportData.userId));
      case UserType.customer:
        formData.fields.add(MapEntry("customer_user_id", reportData.userId));
    }

    if (reportData.attach1 != null) {
      final String fileName = reportData.attach1!.path.split('/').last;
      formData.files.add(
        MapEntry(
          "attach1",
          MultipartFile.fromFileSync(
            reportData.attach1!.path,
            filename: fileName,
          ),
        ),
      );
    }
    if (reportData.attach2 != null) {
      final String fileName = reportData.attach2!.path.split('/').last;
      formData.files.add(
        MapEntry(
          "attach2",
          MultipartFile.fromFileSync(
            reportData.attach2!.path,
            filename: fileName,
          ),
        ),
      );
    }
    if (reportData.attach3 != null) {
      final String fileName = reportData.attach3!.path.split('/').last;
      formData.files.add(
        MapEntry(
          "attach3",
          MultipartFile.fromFileSync(
            reportData.attach3!.path,
            filename: fileName,
          ),
        ),
      );
    }

    return repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.reportIssue,
      formData: formData,
    );
  }
}
