import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/models/password_strength_model.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class PasswordStrengtView extends StatelessWidget {
  const PasswordStrengtView(
      {super.key, required this.passwordStrengthValidationNotifier});
  final ValueNotifier<PasswordStrengthModel> passwordStrengthValidationNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<PasswordStrengthModel>(
        valueListenable: passwordStrengthValidationNotifier,
        builder: (context, data, child) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: AppLocalizations.of(context)!.createAccountMaxChar,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  textColor: data.min8max30Cchar == null
                      ? const Color(0xff384048)
                      : data.min8max30Cchar!
                          ? const Color(0xff008480)
                          : const Color(0xffE74C4C),
                ),
                const SizedBox(height: 2),
                CustomText(
                  title: AppLocalizations.of(context)!.createAccountLowerCase,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  textColor: data.oneLowerCase == null
                      ? const Color(0xff384048)
                      : data.oneLowerCase!
                          ? const Color(0xff008480)
                          : const Color(0xffE74C4C),
                ),
                const SizedBox(height: 2),
                CustomText(
                  title: AppLocalizations.of(context)!.createAccountUpperCase,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  textColor: data.oneUpperCase == null
                      ? const Color(0xff384048)
                      : data.oneUpperCase!
                          ? const Color(0xff008480)
                          : const Color(0xffE74C4C),
                ),
                const SizedBox(height: 2),
                CustomText(
                  title: AppLocalizations.of(context)!.createAccountNumber,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  textColor: data.oneNumber == null
                      ? const Color(0xff384048)
                      : data.oneNumber!
                          ? const Color(0xff008480)
                          : const Color(0xffE74C4C),
                ),
                const SizedBox(height: 2),
                CustomText(
                  title: AppLocalizations.of(context)!.createAccountchar,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  textColor: data.oneSpicialChar == null
                      ? const Color(0xff384048)
                      : data.oneSpicialChar!
                          ? const Color(0xff008480)
                          : const Color(0xffE74C4C),
                ),
              ],
            ),
          );
        });
  }
}
