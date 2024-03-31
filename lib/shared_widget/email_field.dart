import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/custom_textfield.dart';

class EmailFieldLogin extends StatelessWidget {
  final TextEditingController controller;
  final ValueNotifier<bool> showHideEmailClearNotifier;
  final Function() onchange;
  final Function() onClear;
  final Function() onEditingComplete;

  const EmailFieldLogin(
      {super.key,
      required this.controller,
      required this.showHideEmailClearNotifier,
      required this.onchange,
      required this.onClear,
      required this.onEditingComplete});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: CustomTextField(
        controller: controller,
        hintText: AppLocalizations.of(context)!.emailaddress,
        keyboardType: TextInputType.emailAddress,
        inputFormatters: [
          LengthLimitingTextInputFormatter(45),
        ],
        suffixWidget: ValueListenableBuilder<bool>(
            valueListenable: showHideEmailClearNotifier,
            builder: (context, snapshot, child) {
              return snapshot
                  ? IconButton(
                      onPressed: () => onClear(),
                      icon: Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.grey[500],
                      ),
                    )
                  : Container();
            }),
        onChange: (text) => onchange(),
        onEditingComplete: () => onEditingComplete(),
      ),
    );
  }
}
