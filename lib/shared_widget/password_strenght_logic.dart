import 'package:flutter/material.dart';

import '../../../models/password_strength_model.dart';

class PasswordsStrength {
  bool checkerOfThePasswordStrength(
      {required ValueNotifier<PasswordStrengthModel>
          passwordStrengthValidationNotifier}) {
    return passwordStrengthValidationNotifier.value.min8max30Cchar! &&
        passwordStrengthValidationNotifier.value.oneLowerCase! &&
        passwordStrengthValidationNotifier.value.oneNumber! &&
        passwordStrengthValidationNotifier.value.oneUpperCase! &&
        passwordStrengthValidationNotifier.value.oneSpicialChar!;
  }

  validatePasswordStrength(
      {required TextEditingController passwordFieldController,
      required ValueNotifier<PasswordStrengthModel>
          passwordStrengthValidationNotifier}) {
    var passwordStrength = PasswordStrengthModel();

    if (passwordFieldController.text.isNotEmpty) {
      if (passwordFieldController.text.length >= 8 &&
          passwordFieldController.text.length <= 30) {
        passwordStrength.min8max30Cchar = true;
      } else {
        passwordStrength.min8max30Cchar = false;
      }
      if (passwordFieldController.text.contains(RegExp(r'[A-Z]'))) {
        passwordStrength.oneUpperCase = true;
      } else {
        passwordStrength.oneUpperCase = false;
      }
      if (passwordFieldController.text.contains(RegExp(r'[a-z]'))) {
        passwordStrength.oneLowerCase = true;
      } else {
        passwordStrength.oneLowerCase = false;
      }
      if (passwordFieldController.text.contains(RegExp(r'[0-9]'))) {
        passwordStrength.oneNumber = true;
      } else {
        passwordStrength.oneNumber = false;
      }
      if (passwordFieldController.text
          .contains(RegExp(r'[!?@#\$^%;+:&%*~=£€¥/÷×\,.")}{(_-]'))) {
        passwordStrength.oneSpicialChar = true;
      } else {
        passwordStrength.oneSpicialChar = false;
      }
    }

    passwordStrengthValidationNotifier.value = passwordStrength;
  }
}
