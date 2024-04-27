import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/shared_widget/custom_textfield.dart';

class IbanView extends StatelessWidget {
  const IbanView({super.key, required this.controller, required this.onChange});
  final TextEditingController controller;
  final Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 5,
              offset: const Offset(0, 0.1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              CustomText(
                title: AppLocalizations.of(context)!.ibaninfo,
                fontSize: 14,
                textAlign: TextAlign.center,
                textColor: const Color(0xff444444),
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: controller,
                padding: const EdgeInsets.only(left: 8, right: 8),
                hintText: "",
                fontSize: 20,
                keyboardType: TextInputType.name,
                inputFormatters: [LengthLimitingTextInputFormatter(30)],
                onChange: onChange,
                onEditingComplete: () =>
                    FocusManager.instance.primaryFocus?.unfocus(),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
