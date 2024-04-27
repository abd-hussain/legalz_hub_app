import 'package:local_auth/local_auth.dart';

class AuthenticationResult {
  AuthenticationResult({required this.success, required this.errorMessage});
  bool success;
  String errorMessage;
}

class UserAuthenticationBlockResult {
  UserAuthenticationBlockResult({required this.shouldAllowUser, required this.dateOfAllowed});
  bool shouldAllowUser;
  String dateOfAllowed;
}

class AuthenticationBiometricType {
  AuthenticationBiometricType({required this.isAvailable, required this.type});
  bool isAvailable;
  BiometricType? type;
}
