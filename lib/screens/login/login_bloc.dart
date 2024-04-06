import 'dart:async';
import 'dart:convert';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/locator.dart';
import 'package:legalz_hub_app/models/authentication_models.dart';
import 'package:legalz_hub_app/models/https/login_request.dart';
import 'package:legalz_hub_app/services/auth_services.dart';
import 'package:legalz_hub_app/services/general/authentication_service.dart';
import 'package:legalz_hub_app/services/general/network_info_service.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/loading_status.dart';
import 'package:legalz_hub_app/utils/error/exceptions.dart';
import 'package:legalz_hub_app/utils/mixins.dart';
import 'package:legalz_hub_app/utils/routes.dart';

class LoginBloc extends Bloc<AuthService> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  BuildContext? maincontext;
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  ValueNotifier<bool> fieldsValidations = ValueNotifier<bool>(false);

  ValueNotifier<bool> showHideEmailClearNotifier = ValueNotifier<bool>(false);
  ValueNotifier<bool> showHidePasswordClearNotifier =
      ValueNotifier<bool>(false);
  ValueNotifier<LoadingStatus> loadingStatusNotifier =
      ValueNotifier<LoadingStatus>(LoadingStatus.idle);
  ValueNotifier<String> errorMessage = ValueNotifier<String>("");

  ValueNotifier<bool> buildNotifier = ValueNotifier<bool>(false);

  ValueNotifier<AuthenticationBiometricType> biometricResultNotifier =
      ValueNotifier<AuthenticationBiometricType>(
          AuthenticationBiometricType(isAvailable: false, type: null));
  bool isBiometricAppeared = false;
  bool biometricStatus = false;
  final authenticationService = locator<AuthenticationService>();

  fieldValidation() {
    fieldsValidations.value = false;
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      if (_validateEmail(emailController.text)) {
        errorMessage.value = "";
        fieldsValidations.value = true;
      } else {
        errorMessage.value =
            AppLocalizations.of(maincontext!)!.emailformatnotvalid;
      }
    }
  }

  handleListeners() {
    emailController.addListener(_emailListen);
    passwordController.addListener(_passwordListen);
  }

  getUserNameAndPasswordWhenSavePasswordTicked() {
    if (box.get(DatabaseFieldConstant.saveEmailAndPassword) == true) {
      emailController.text = box.get(DatabaseFieldConstant.biometricU) ?? "";
      passwordController.text = box.get(DatabaseFieldConstant.biometricP) ?? "";
      fieldsValidations.value = true;
      loadingStatusNotifier.value = LoadingStatus.finish;
    }
  }

  void _emailListen() {
    showHideEmailClearNotifier.value = emailController.text.isNotEmpty;
  }

  void _passwordListen() {
    showHidePasswordClearNotifier.value = passwordController.text.isNotEmpty;
  }

  Future<void> initBiometric(BuildContext context) async {
    if (await locator<NetworkInfoService>().isConnected()) {
      if (context.mounted) {
        await _readBiometricData(context);
      }
    }
  }

  Future<void> _readBiometricData(BuildContext context) async {
    final String biometricU = box.get(DatabaseFieldConstant.biometricU) ?? "";
    final String biometricP = box.get(DatabaseFieldConstant.biometricP) ?? "";
    isBiometricAppeared = true;
    biometricStatus =
        box.get(DatabaseFieldConstant.biometricStatus) == 'true' &&
            biometricP.isNotEmpty &&
            biometricU.isNotEmpty;

    if (await _checkAuthentication(Theme.of(context).platform)) {
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        Future.delayed(
          const Duration(seconds: 1),
          () async {
            if (biometricStatus) {
              await tryToAuthintecateUserByBiometric(context);
            }
          },
        );
      });
    } else {
      isBiometricAppeared = false;
    }
  }

  Future tryToAuthintecateUserByBiometric(BuildContext context) async {
    if (await authenticationService.isBiometricAvailable()) {
      if (context.mounted) {
        if (await authenticationService
            .shouldAllowBiometricAuthenticationToContinue(
                Theme.of(context).platform)) {
          // continue with authentication
          isBiometricAppeared = true;
          final authentication = await authenticationService.authenticateUser(
              AppLocalizations.of(maincontext!)!.pleaseuseyourbiometrics);
          if (authentication.success) {
            final String biometricU = box.get(DatabaseFieldConstant.biometricU);
            final String biometricP = box.get(DatabaseFieldConstant.biometricP);

            if (!(await locator<NetworkInfoService>().isConnected())) {
              throw ConnectionException(
                  message: AppLocalizations.of(maincontext!)!
                      .pleasecheckyourinternetconnection);
            } else {
              if (context.mounted) {
                doLoginCall(
                  context: context,
                  userName: biometricU,
                  password: biometricP,
                  isBiometricLogin: true,
                );
                isBiometricAppeared = false;
              }
            }
          } else {
            isBiometricAppeared = false;
          }
        }
      } else {
        isBiometricAppeared = false;
      }
    }
  }

  Future<bool> _checkAuthentication(TargetPlatform platform) async {
    if (await authenticationService.isBiometricAvailable()) {
      biometricResultNotifier.value =
          await (authenticationService.getAvailableBiometricTypes(platform));
      buildNotifier.value = true;
      return true;
    }
    return false;
  }

  bool _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    return (!regex.hasMatch(value)) ? false : true;
  }

  void _openMainScreen(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
        RoutesConstants.mainContainer, (Route<dynamic> route) => false);
  }

  _saveValuesInMemory(
      {required String userName,
      required String password,
      required String token,
      required String userType}) async {
    await box.put(DatabaseFieldConstant.token, token);
    await box.put(DatabaseFieldConstant.biometricU, userName);
    await box.put(DatabaseFieldConstant.biometricP, password);
    await box.put(DatabaseFieldConstant.userType, userType);

    await getUserIdFromJWT(token);
  }

  getUserIdFromJWT(String token) async {
    final parts = token.split('.');
    final payload = parts[1];
    final String decoded = B64urlEncRfc7515.decodeUtf8(payload);
    Map valueMap = json.decode(decoded);
    await box.put(DatabaseFieldConstant.userid, valueMap["user_id"]);
  }

  void doLoginCall(
      {required BuildContext context,
      required String userName,
      required String password,
      bool isBiometricLogin = false}) async {
    loadingStatusNotifier.value = LoadingStatus.inprogress;
    final LoginRequest loginData =
        LoginRequest(email: userName, password: password);

    try {
      final info = await service.login(loginData: loginData);
      await _saveValuesInMemory(
          userName: userName,
          password: password,
          token: info["data"]["Bearer"],
          userType: info["data"]["user"]);
      loadingStatusNotifier.value = LoadingStatus.finish;
      _openMainScreen(maincontext!);
    } on DioException catch (e) {
      final error = e.error as HttpException;
      loadingStatusNotifier.value = LoadingStatus.finish;

      if (error.message.toString() == "Invalid Attorney Password" ||
          error.message.toString() == "Invalid Credentials") {
        errorMessage.value =
            AppLocalizations.of(maincontext!)!.wrongemailorpassword;
      } else if (error.message.toString() == "Attorney Blocked" ||
          error.message.toString() == "customer Blocked") {
        errorMessage.value = AppLocalizations.of(maincontext!)!.userblocked;
      } else if (error.message.toString() == "Attorney Under Review") {
        errorMessage.value =
            AppLocalizations.of(maincontext!)!.userstillunderreview;
      } else {
        errorMessage.value = error.message.toString();
      }
    }
  }

  @override
  onDispose() {}
}
