import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class MobileHeader extends StatelessWidget {
  const MobileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: CustomText(
            title: AppLocalizations.of(context)!.pleaseenteryourphonenumber,
            fontSize: 14,
            textColor: const Color(0xff444444),
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: CustomText(
            title: AppLocalizations.of(context)!.enteryourphonenumberexample,
            fontSize: 10,
            textColor: Colors.grey,
          ),
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}
