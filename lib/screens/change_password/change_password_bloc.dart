import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/models/https/update_password_request.dart';
import 'package:legalz_hub_app/models/password_strength_model.dart';
import 'package:legalz_hub_app/services/settings_service.dart';
import 'package:legalz_hub_app/shared_widget/password_strenght_logic.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/loading_status.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/mixins.dart';

class ChangePasswordBloc extends Bloc<SettingService> {
  bool currentPassowrdObscureText = true;
  bool newPasswordObscureText = true;
  bool confirmPasswordObscureText = true;
  bool enableSaveButton = false;
  bool enableNewPasswordTextField = false;
  bool enableConfirmPasswordTextField = false;
  ValueNotifier<LoadingStatus> loadingStatus =
      ValueNotifier<LoadingStatus>(LoadingStatus.idle);
  UserType userType = UserType.customer;

  final TextEditingController currentPasswordFieldController =
      TextEditingController();
  final TextEditingController newPasswordFieldController =
      TextEditingController();
  final TextEditingController confirmPasswordFieldController =
      TextEditingController();

  final ValueNotifier<PasswordStrengthModel>
      passwordStrengthValidationNotifier =
      ValueNotifier<PasswordStrengthModel>(PasswordStrengthModel());

  final ValueNotifier<String> infoNotifier = ValueNotifier<String>("");
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  bool validateCurrentPassword(BuildContext context, String text) {
    if (box.get(DatabaseFieldConstant.biometricP) == text) {
      infoNotifier.value = AppLocalizations.of(context)!.fillnewpassword;
      enableNewPasswordTextField = true;
      return true;
    }
    infoNotifier.value = AppLocalizations.of(context)!.currentpasswordwrong;
    return false;
  }

  void clearFields() {
    currentPasswordFieldController.clear();
    newPasswordFieldController.clear();
    confirmPasswordFieldController.clear();
    enableNewPasswordTextField = false;
    enableConfirmPasswordTextField = false;
    passwordStrengthValidationNotifier.value = PasswordStrengthModel();
  }

  bool checkerOfThePasswordStrength() {
    return PasswordsStrength().checkerOfThePasswordStrength(
        passwordStrengthValidationNotifier: passwordStrengthValidationNotifier);
  }

  Future<dynamic> changePasswordRequest() {
    final UpdatePasswordRequest passObj = UpdatePasswordRequest(
      oldPassword: currentPasswordFieldController.text,
      newPassword: confirmPasswordFieldController.text,
      userType: userType == UserType.attorney ? "attorney" : "customer",
    );
    return service.changePassword(account: passObj);
  }

  @override
  void onDispose() {
    clearFields();
    loadingStatus.dispose();
    currentPasswordFieldController.dispose();
    newPasswordFieldController.dispose();
    confirmPasswordFieldController.dispose();
    passwordStrengthValidationNotifier.dispose();
  }
}
