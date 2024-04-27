import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/services/filter_services.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/mixins.dart';

class AttorneyRegister5Bloc extends Bloc<FilterService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);
  bool statusOfSaveEmailAndPassword = true;

  ValueNotifier<bool> enableNextBtn = ValueNotifier<bool>(false);

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  ValueNotifier<bool> showHidePasswordClearNotifier =
      ValueNotifier<bool>(false);
  ValueNotifier<bool> showHideConfirmPasswordClearNotifier =
      ValueNotifier<bool>(false);

  ValueNotifier<bool> passwordEquilConfirmPasswordNotifier =
      ValueNotifier<bool>(false);
  ValueNotifier<bool> passwordMoreThan8CharNotifier =
      ValueNotifier<bool>(false);
  ValueNotifier<bool> passwordHaveNumberNotifier = ValueNotifier<bool>(false);

  TextEditingController emailController = TextEditingController();
  ValueNotifier<String> validateEmail = ValueNotifier<String>("");

  void tryToFillTheFields() {
    if (box.get(TempFieldToRegistrtAttorneyConstant.email) != null) {
      emailController.text = box.get(TempFieldToRegistrtAttorneyConstant.email);
    }
    if (box.get(TempFieldToRegistrtAttorneyConstant.password) != null) {
      passwordController.text =
          box.get(TempFieldToRegistrtAttorneyConstant.password);
      confirmPasswordController.text =
          box.get(TempFieldToRegistrtAttorneyConstant.password);
    }

    validateFieldsForFaze5();
  }

  void handleListeners() {
    passwordController.addListener(_passwordListen);
    confirmPasswordController.addListener(_confirmPasswordListen);
  }

  void _passwordListen() {
    showHidePasswordClearNotifier.value = passwordController.text.isNotEmpty;
    validateFieldsForFaze5();
  }

  void _confirmPasswordListen() {
    showHideConfirmPasswordClearNotifier.value =
        confirmPasswordController.text.isNotEmpty;
    validateFieldsForFaze5();
  }

  void validateEmailMethod(BuildContext context) {
    if (validateEmailRegix()) {
      validateEmail.value = "";
      validateEmailAPI(context);
    } else {
      validateEmail.value = AppLocalizations.of(context)!.emailformatnotvalid;
    }
  }

  bool validateEmailRegix() {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text)) {
      return true;
    }

    return false;
  }

  void validateEmailAPI(BuildContext context) {
    service.validateEmailAddress(emailController.text).then((value) {
      if (value) {
        validateEmail.value = AppLocalizations.of(context)!.emailalreadyinuse;
      } else {
        validateEmail.value = "";
      }
      validateFieldsForFaze5();
    });
  }

  void validateFieldsForFaze5() {
    if (passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
      passwordEquilConfirmPasswordNotifier.value =
          (passwordController.text == confirmPasswordController.text);
      passwordMoreThan8CharNotifier.value =
          passwordController.text.length >= 8 ||
              confirmPasswordController.text.length >= 8;
      passwordHaveNumberNotifier.value =
          passwordController.text.contains(RegExp('[0-9]')) ||
              confirmPasswordController.text.contains(RegExp('[0-9]'));

      enableNextBtn.value = passwordEquilConfirmPasswordNotifier.value &&
          passwordMoreThan8CharNotifier.value &&
          passwordHaveNumberNotifier.value &&
          validateEmailRegix();
    }
  }

  @override
  void onDispose() {}
}
