import 'package:legalz_hub_app/utils/mixins.dart';

class ForgotPasswordRequest implements Model {
  ForgotPasswordRequest({
    required this.email,
  });
  String email;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['email'] = email;
    return data;
  }
}
