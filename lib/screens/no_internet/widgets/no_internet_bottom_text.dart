import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class BottomText extends StatelessWidget {
  const BottomText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Column(
        children: [
          CustomText(
            title: AppLocalizations.of(context)!.nointernetconnection,
            fontSize: 18,
            textColor: const Color(0xff444444),
          ),
          const SizedBox(height: 10),
          CustomText(
            textAlign: TextAlign.center,
            maxLins: 2,
            title: AppLocalizations.of(context)!.nointernetconnectiondesc,
            fontSize: 14,
            textColor: const Color(0xff444444),
          ),
        ],
      ),
    );
  }
}
