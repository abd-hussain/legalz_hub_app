import 'package:legalz_hub_app/utils/mixins.dart';

class UpdatePasswordRequest implements Model {
  String oldPassword;
  String newPassword;
  String userType;

  UpdatePasswordRequest({
    required this.oldPassword,
    required this.newPassword,
    required this.userType,
  });

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['oldpassword'] = oldPassword;
    data['newpassword'] = newPassword;
    data['userType'] = userType;
    return data;
  }
}
