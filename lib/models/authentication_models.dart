import 'package:local_auth/local_auth.dart';

class AuthenticationResult {
  bool success;
  String errorMessage;

  AuthenticationResult({required this.success, required this.errorMessage});
}

class UserAuthenticationBlockResult {
  bool shouldAllowUser;
  String dateOfAllowed;

  UserAuthenticationBlockResult(
      {required this.shouldAllowUser, required this.dateOfAllowed});
}

class AuthenticationBiometricType {
  bool isAvailable;
  BiometricType? type;

  AuthenticationBiometricType({required this.isAvailable, required this.type});
}
