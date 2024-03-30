import 'package:flutter/cupertino.dart';
import 'package:legalz_hub_app/locator.dart';
import 'package:legalz_hub_app/models/authentication_models.dart';
import 'package:legalz_hub_app/utils/mixins.dart';
import 'package:local_auth/local_auth.dart';

class AuthenticationService with Service {
  final LocalAuthentication? localAuthentication =
      locator<LocalAuthentication>();

  // Check if any hardware regarding authentication is available
  Future<bool> isBiometricAvailable() async {
    return await localAuthentication!.canCheckBiometrics &&
        await localAuthentication!.isDeviceSupported();
  }

  // if authentication should be allowed
  Future<bool> shouldAllowBiometricAuthenticationToContinue(
      TargetPlatform? platform) async {
    if (platform == TargetPlatform.iOS) {
      return Future.value(true);
    } else if (platform == TargetPlatform.android) {
      // We need to check the biometric types available, if finger print is available, return true, otherwise, return false
      final listOfBiometricsAvailable =
          await localAuthentication!.getAvailableBiometrics();
      var shouldAuthenticate = false;
      if (listOfBiometricsAvailable.isNotEmpty) {
        shouldAuthenticate = true;
      }
      return Future.value(shouldAuthenticate);
    } else {
      return Future.value(false);
    }
  }

  // Process of authentication user using
  // biometrics.
  Future<AuthenticationResult> authenticateUser(
      String localizedAuthenticationMessage) async {
    return localAuthentication!
        .authenticate(
      options: const AuthenticationOptions(
          biometricOnly: true, useErrorDialogs: true, stickyAuth: true),
      localizedReason: localizedAuthenticationMessage,
    )
        .then((value) async {
      return AuthenticationResult(
          success: value, errorMessage: value ? "" : "Authentication Failed");
    }).catchError((error) async {
      return AuthenticationResult(
          success: false, errorMessage: error.toString());
    });
  }

  Future<AuthenticationBiometricType> getAvailableBiometricTypes(
      TargetPlatform? platform) async {
    // Note : if isAvailable = false then we ignore the BiometricType

    AuthenticationBiometricType? response = AuthenticationBiometricType(
        isAvailable: false, type: BiometricType.iris);
    return await localAuthentication!
        .getAvailableBiometrics()
        .then((listOfBiometrics) {
      for (final biometricType in listOfBiometrics) {
        response =
            AuthenticationBiometricType(isAvailable: true, type: biometricType);
      }

      return Future.value(response);
    });
  }
}
