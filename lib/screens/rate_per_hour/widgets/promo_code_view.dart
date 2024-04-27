import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class PromoCodeView extends StatelessWidget {
  const PromoCodeView({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Center(
        child: CustomText(
          title: AppLocalizations.of(context)!.promocodewillsended,
          fontSize: 12,
          maxLins: 3,
          textColor: const Color(0xff444444),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
