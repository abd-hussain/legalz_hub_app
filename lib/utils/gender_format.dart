import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GenderFormat {
  String convertIndexToString(BuildContext context, int index) {
    if (index == 0) {
      return AppLocalizations.of(context)!.gendermale;
    } else if (index == 1) {
      return AppLocalizations.of(context)!.genderfemale;
    } else {
      return AppLocalizations.of(context)!.genderother;
    }
  }

  int convertStringToIndex(BuildContext context, String value) {
    if (value == AppLocalizations.of(context)!.gendermale) {
      return 0;
    } else if (value == AppLocalizations.of(context)!.genderfemale) {
      return 1;
    } else {
      return 2;
    }
  }
}
