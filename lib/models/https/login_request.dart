import 'package:legalz_hub_app/utils/mixins.dart';

class LoginRequest implements Model {
  LoginRequest({
    required this.email,
    required this.password,
  });
  String email;
  String password;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, String> data = {};
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
