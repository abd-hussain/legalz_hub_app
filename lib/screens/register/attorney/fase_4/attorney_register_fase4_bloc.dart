import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/services/filter_services.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/mixins.dart';

class AttorneyRegister4Bloc extends Bloc<FilterService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  ValueNotifier<bool> enableNextBtn = ValueNotifier<bool>(false);

  TextEditingController ratePerHourController = TextEditingController();
  TextEditingController ibanController = TextEditingController();

  String ibanRes = "";

  tryToFillTheFields() {
    if (box.get(TempFieldToRegistrtAttorneyConstant.iban) != null) {
      ibanController.text = box.get(TempFieldToRegistrtAttorneyConstant.iban);
    }

    if (box.get(TempFieldToRegistrtAttorneyConstant.ratePerHour) != null) {
      ratePerHourController.text = box.get(TempFieldToRegistrtAttorneyConstant.ratePerHour);
    }
    validateFieldsForFaze4();
  }

  String getUserCurrency() {
    return box.get(DatabaseFieldConstant.selectedCountryCurrency) ?? "\$";
  }

  validateFieldsForFaze4() {
    if (ratePerHourController.text.isNotEmpty) {
      double convertedText = double.tryParse(ratePerHourController.text) ?? 0.0;
      if (convertedText > 0) {
        enableNextBtn.value = true;
      } else {
        enableNextBtn.value = false;
      }
    } else {
      enableNextBtn.value = false;
    }
  }

  encreseRatePerHourBy1() {
    if (ratePerHourController.text.isEmpty) {
      ratePerHourController.text = "1.0";
    }

    double convertedText = double.tryParse(ratePerHourController.text) ?? 0.0;

    if (convertedText < 1000) {
      convertedText = convertedText + 1;
      ratePerHourController.text = convertedText.toStringAsFixed(2);
    }

    validateFieldsForFaze4();
  }

  decreseRatePerHourBy1() {
    if (ratePerHourController.text.isEmpty) {
      ratePerHourController.text = "1.0";
    }
    double convertedText = double.tryParse(ratePerHourController.text) ?? 0.0;

    if (convertedText > 1) {
      convertedText = convertedText - 1;
      ratePerHourController.text = convertedText.toStringAsFixed(2);
    }
    validateFieldsForFaze4();
  }

  @override
  onDispose() {}
}
