import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/custom_button.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/shared_widget/custom_textfield.dart';

class DiscountView extends StatelessWidget {
  final TextEditingController controller;
  final ValueListenable<bool> applyDiscountButton;
  final ValueListenable<String> discountErrorMessage;
  final Function() applyDiscountButtonCallBack;
  const DiscountView({
    required this.controller,
    required this.applyDiscountButton,
    required this.discountErrorMessage,
    required this.applyDiscountButtonCallBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 50,
              child: CustomTextField(
                controller: controller,
                fontSize: 25,
                hintText: AppLocalizations.of(context)!.discountcode,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(6),
                ],
                suffixWidget: IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 20,
                  ),
                  onPressed: () {
                    controller.text = "";
                  },
                ),
                onEditingComplete: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              ),
            ),
            ValueListenableBuilder<String>(
                valueListenable: discountErrorMessage,
                builder: (context, snapshot, child) {
                  return snapshot != ""
                      ? Padding(
                          padding:
                              const EdgeInsets.only(top: 2, left: 8, right: 8),
                          child: CustomText(
                            title: snapshot == "error"
                                ? AppLocalizations.of(context)!
                                    .notvaliddiscountcode
                                : AppLocalizations.of(context)!
                                    .validdiscountcode,
                            fontSize: 14,
                            textColor:
                                snapshot == "error" ? Colors.red : Colors.green,
                          ),
                        )
                      : const SizedBox();
                }),
          ],
        ),
        Expanded(child: Container()),
        ValueListenableBuilder<bool>(
            valueListenable: applyDiscountButton,
            builder: (context, snapshot, child) {
              return CustomButton(
                enableButton: snapshot,
                width: MediaQuery.of(context).size.width * 0.2,
                buttonTitle: AppLocalizations.of(context)!.apply,
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  applyDiscountButtonCallBack();
                },
              );
            }),
      ],
    );
  }
}
