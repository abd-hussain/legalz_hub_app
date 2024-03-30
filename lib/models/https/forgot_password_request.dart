import 'package:legalz_hub_app/utils/mixins.dart';

class ForgotPasswordRequest implements Model {
  String email;

  ForgotPasswordRequest({
    required this.email,
  });

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['email'] = email;
    return data;
  }
}
