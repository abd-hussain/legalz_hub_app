import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legalz_hub_app/models/https/countries_model.dart';
import 'package:legalz_hub_app/shared_widget/bottom_sheet_util.dart';
import 'package:legalz_hub_app/shared_widget/custom_textfield.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CountryField extends StatelessWidget {
  final TextEditingController controller;
  final List<Country> listOfCountries;
  final Function(Country) selectedCountry;
  const CountryField(
      {required this.controller,
      required this.listOfCountries,
      required this.selectedCountry,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomTextField(
          readOnly: true,
          controller: controller,
          hintText: AppLocalizations.of(context)!.countryprofile,
          padding: const EdgeInsets.only(left: 16, right: 16),
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(45),
          ],
        ),
        InkWell(
          onTap: () async {
            await BottomSheetsUtil().countryBottomSheet(
                context, listOfCountries, (countrySelected) {
              controller.text = countrySelected.name!;
              selectedCountry(countrySelected);
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
