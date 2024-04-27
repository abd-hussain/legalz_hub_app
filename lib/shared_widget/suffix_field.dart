import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/models/https/suffix_model.dart';
import 'package:legalz_hub_app/shared_widget/bottom_sheet_util.dart';
import 'package:legalz_hub_app/shared_widget/custom_textfield.dart';

class SuffixField extends StatelessWidget {
  const SuffixField(
      {required this.controller,
      required this.listOfSuffix,
      required this.selectedSuffix,
      super.key});
  final TextEditingController controller;
  final List<SuffixData> listOfSuffix;
  final Function(SuffixData) selectedSuffix;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomTextField(
          readOnly: true,
          controller: controller,
          hintText: AppLocalizations.of(context)!.suffixenameprofile,
          keyboardType: TextInputType.name,
          inputFormatters: [
            LengthLimitingTextInputFormatter(45),
          ],
        ),
        InkWell(
          onTap: () async {
            await BottomSheetsUtil().suffixBottomSheet(context, listOfSuffix,
                (suffixSelected) {
              controller.text = suffixSelected.name!;
              selectedSuffix(suffixSelected);
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 16),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 55,
            ),
          ),
        ),
      ],
    );
  }
}
