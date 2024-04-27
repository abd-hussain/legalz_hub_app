import 'package:legalz_hub_app/utils/mixins.dart';

class UpdatePasswordRequest implements Model {
  UpdatePasswordRequest({
    required this.oldPassword,
    required this.newPassword,
    required this.userType,
  });
  String oldPassword;
  String newPassword;
  String userType;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['oldpassword'] = oldPassword;
    data['newpassword'] = newPassword;
    data['userType'] = userType;
    return data;
  }
}
