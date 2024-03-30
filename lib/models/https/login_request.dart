import 'package:legalz_hub_app/utils/mixins.dart';

class LoginRequest implements Model {
  String email;
  String password;

  LoginRequest({
    required this.email,
    required this.password,
  });

  @override
  Map<String, dynamic> toJson() {
    Map<String, String> data = {};
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
