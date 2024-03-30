import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/models/https/countries_model.dart';
import 'package:legalz_hub_app/my_app.dart';
import 'package:legalz_hub_app/services/filter_services.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/mixins.dart';

class SetupBloc extends Bloc<FilterService> {
  final ValueNotifier<int> selectedLanguageNotifier = ValueNotifier<int>(0);
  final ValueNotifier<List<Country>> countriesListNotifier =
      ValueNotifier<List<Country>>([]);
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  Future<void> getSystemLanguage(BuildContext context) async {
    final String? savedLanguage = box.get(DatabaseFieldConstant.language);

    if (savedLanguage == null) {
      _setLanguageFromTheSystem(context: context);
    } else {
      _setLanguageFromTheSavedData(
          context: context, savedLanguage: savedLanguage);
    }
  }

  void _setLanguageFromTheSystem({required BuildContext context}) async {
    Locale activeLocale = Localizations.localeOf(context);

    selectedLanguageNotifier.value = 0;
    await box.put(DatabaseFieldConstant.language, "en");
    if (activeLocale.languageCode == "ar") {
      await box.put(DatabaseFieldConstant.language, "ar");
      selectedLanguageNotifier.value = 1;
    }
  }

  void _setLanguageFromTheSavedData(
      {required BuildContext context, required String savedLanguage}) {
    if (savedLanguage == "ar") {
      selectedLanguageNotifier.value = 1;
      _setLanguageToArabic(context);
    } else {
      selectedLanguageNotifier.value = 0;
      _setLanguageToEnglish(context);
    }
  }

  void listOfCountries() {
    service.countries().then((value) {
      countriesListNotifier.value = value.data!
        ..sort((a, b) => a.id!.compareTo(b.id!));
    });
  }

  Future<void> setLanguageInStorage(BuildContext context, int index) async {
    if (index == 0) {
      _setLanguageToEnglish(context);
    } else {
      _setLanguageToArabic(context);
    }
    selectedLanguageNotifier.value = index;

    listOfCountries();
  }

  void _setLanguageToArabic(BuildContext context) {
    box.put(DatabaseFieldConstant.language, "ar");
    MyApp.of(context)!.rebuild();
  }

  void _setLanguageToEnglish(BuildContext context) {
    box.put(DatabaseFieldConstant.language, "en");
    MyApp.of(context)!.rebuild();
  }

  @override
  onDispose() {
    selectedLanguageNotifier.dispose();
    countriesListNotifier.dispose();
  }
}
