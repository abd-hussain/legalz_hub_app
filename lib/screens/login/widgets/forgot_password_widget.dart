import 'package:flutter/material.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/utils/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          //TODO
          // Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.forgotPasswordScreen);
        },
        child: CustomText(
          title: AppLocalizations.of(context)!.forgotpassword,
          fontSize: 14,
          textColor: Colors.blue,
        ),
      ),
    );
  }
}
