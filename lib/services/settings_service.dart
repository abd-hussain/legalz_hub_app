import 'package:legalz_hub_app/models/https/contact_list_upload.dart';
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
}
