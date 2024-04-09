import 'package:flutter/material.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchForAttorneyView extends StatelessWidget {
  const SearchForAttorneyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset('assets/lottie/98723-search-users.zip', height: 200),
        CustomText(
          title: AppLocalizations.of(context)!.searchforsuitablementor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          textColor: const Color(0xff554d56),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
