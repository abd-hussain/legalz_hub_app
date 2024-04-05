import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class PasswordComplexity extends StatelessWidget {
  final ValueNotifier<bool> passwordEquilConfirmPasswordNotifier;
  final ValueNotifier<bool> passwordMoreThan8CharNotifier;
  final ValueNotifier<bool> passwordHaveNumberNotifier;

  const PasswordComplexity({
    super.key,
    required this.passwordEquilConfirmPasswordNotifier,
    required this.passwordMoreThan8CharNotifier,
    required this.passwordHaveNumberNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          ValueListenableBuilder<bool>(
              valueListenable: passwordEquilConfirmPasswordNotifier,
              builder: (context, snapshot, child) {
                return condition(
                    AppLocalizations.of(context)!.passwordequilconfirmpassword,
                    snapshot);
              }),
          ValueListenableBuilder<bool>(
              valueListenable: passwordMoreThan8CharNotifier,
              builder: (context, snapshot, child) {
                return condition(
                    AppLocalizations.of(context)!.passwordmorethan8char,
                    snapshot);
              }),
          ValueListenableBuilder<bool>(
              valueListenable: passwordHaveNumberNotifier,
              builder: (context, snapshot, child) {
                return condition(
                    AppLocalizations.of(context)!.passwordhavenumbers,
                    snapshot);
              }),
        ],
      ),
    );
  }

  Widget condition(String title, bool status) {
    return Row(
      children: [
        status
            ? const Icon(
                Icons.check,
                color: Color(0xff034061),
                size: 25,
              )
            : const SizedBox(
                width: 25,
                height: 25,
              ),
        CustomText(
          title: title,
          fontSize: 14,
          textColor: status ? const Color(0xff034061) : const Color(0xff444444),
        ),
      ],
    );
  }
}
