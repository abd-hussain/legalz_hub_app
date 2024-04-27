import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class SavePasswordView extends StatefulWidget {
  const SavePasswordView({super.key, required this.selectedStatus});
  final Function(bool) selectedStatus;

  @override
  State<SavePasswordView> createState() => _SavePasswordViewState();
}

class _SavePasswordViewState extends State<SavePasswordView> {
  ValueNotifier<bool> boxSelectedNotifier = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ValueListenableBuilder<bool>(
              valueListenable: boxSelectedNotifier,
              builder: (context, snapshot, child) {
                return Checkbox(
                    checkColor: Colors.white,
                    activeColor: const Color(0xff034061),
                    value: snapshot,
                    onChanged: (val) {
                      boxSelectedNotifier.value = val!;
                      widget.selectedStatus(val);
                    });
              }),
          CustomText(
            title:
                AppLocalizations.of(context)!.saveemailandpasswordfornextlogin,
            fontSize: 14,
            textColor: const Color(0xff444444),
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }
}
