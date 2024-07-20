import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/custom_button.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:lottie/lottie.dart';

class NoMentorFoundView extends StatelessWidget {
  const NoMentorFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/lottie/62575-freelancer-working.zip',
              width: MediaQuery.of(context).size.width - 20),
          CustomText(
            title: AppLocalizations.of(context)!
                .nothingfoundunderthiscategoryandmajor,
            fontSize: 18,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.bold,
            textColor: const Color(0xff554d56),
            maxLins: 3,
          ),
          const SizedBox(height: 20),
          CustomButton(
            enableButton: true,
            buttonTitle: AppLocalizations.of(context)!.backtothepreviosscreen,
            onTap: () async {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
