import 'package:legalz_hub_app/utils/mixins.dart';

class UpdatePasswordRequest implements Model {
  String oldPassword;
  String newPassword;

  UpdatePasswordRequest({
    required this.oldPassword,
    required this.newPassword,
  });

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['oldpassword'] = oldPassword;
    data['newpassword'] = newPassword;
    return data;
  }
}
