import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/models/gender_model.dart';
import 'package:legalz_hub_app/shared_widget/bottom_sheet_util.dart';
import 'package:legalz_hub_app/shared_widget/custom_textfield.dart';

class GenderField extends StatelessWidget {
  const GenderField(
      {required this.controller, super.key, required this.onChange});
  final TextEditingController controller;
  final Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomTextField(
          controller: controller,
          readOnly: true,
          hintText: AppLocalizations.of(context)!.gender,
          keyboardType: TextInputType.text,
          inputFormatters: [
            LengthLimitingTextInputFormatter(45),
          ],
          onChange: (text) => onChange(controller.text),
        ),
        InkWell(
          onTap: () async {
            await BottomSheetsUtil().genderBottomSheet(
                context, genderList(context), (selectedGender) {
              controller.text = selectedGender.name;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 55,
            ),
          ),
        ),
      ],
    );
  }

  List<Gender> genderList(BuildContext context) {
    return [
      Gender(
        name: AppLocalizations.of(context)!.gendermale,
        icon: const Icon(Icons.male, color: Color(0xff444444)),
      ),
      Gender(
        name: AppLocalizations.of(context)!.genderfemale,
        icon: const Icon(Icons.female, color: Color(0xff444444)),
      ),
      Gender(
          name: AppLocalizations.of(context)!.genderother,
          icon: const Icon(Icons.align_horizontal_center,
              color: Color(0xff444444)))
    ];
  }
}
