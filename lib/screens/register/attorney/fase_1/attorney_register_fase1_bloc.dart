import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/models/https/countries_model.dart';
import 'package:legalz_hub_app/models/https/suffix_model.dart';
import 'package:legalz_hub_app/services/filter_services.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/loading_status.dart';
import 'package:legalz_hub_app/utils/mixins.dart';

class AttorneyRegister1Bloc extends Bloc<FilterService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  TextEditingController suffixNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController referalCodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  String profileImageUrl = "";
  String iDImageUrl = "";
  String? selectedDate;

  File? profileImage;
  File? iDImage;

  Country? selectedCountry;
  SuffixData? selectedSuffix;

  ValueNotifier<bool?> validateReferalCode = ValueNotifier<bool?>(null);

  ValueNotifier<List<Country>> listOfCountries =
      ValueNotifier<List<Country>>([]);
  ValueNotifier<List<SuffixData>> listOfSuffix =
      ValueNotifier<List<SuffixData>>([]);
  StreamController<LoadingStatus> loadingStatusController =
      StreamController<LoadingStatus>();
  ValueNotifier<bool> mobileNumberErrorMessage = ValueNotifier<bool>(false);

  String countryCode = "";
  Country? country;

  String mobileController = "";
  bool validatePhoneNumber = false;

  StreamController<bool> enableNextBtn = StreamController<bool>();

  tryToFillTheFields() {
    if (box.get(TempFieldToRegistrtAttorneyConstant.suffix) != null) {
      suffixNameController.text =
          box.get(TempFieldToRegistrtAttorneyConstant.suffix);
    }
    if (box.get(TempFieldToRegistrtAttorneyConstant.firstName) != null) {
      firstNameController.text =
          box.get(TempFieldToRegistrtAttorneyConstant.firstName);
    }

    if (box.get(TempFieldToRegistrtAttorneyConstant.lastName) != null) {
      lastNameController.text =
          box.get(TempFieldToRegistrtAttorneyConstant.lastName);
    }

    if (box.get(TempFieldToRegistrtAttorneyConstant.dateOfBirth) != null) {
      selectedDate = box.get(TempFieldToRegistrtAttorneyConstant.dateOfBirth);
    }

    if (box.get(TempFieldToRegistrtAttorneyConstant.gender) != null) {
      genderController.text =
          box.get(TempFieldToRegistrtAttorneyConstant.gender);
    }

    if (box.get(TempFieldToRegistrtAttorneyConstant.profileImage) != null) {
      profileImageUrl =
          box.get(TempFieldToRegistrtAttorneyConstant.profileImage);
    }

    if (box.get(TempFieldToRegistrtAttorneyConstant.idImage) != null) {
      iDImageUrl = box.get(TempFieldToRegistrtAttorneyConstant.idImage);
    }

    if (box.get(TempFieldToRegistrtAttorneyConstant.referalCode) != null) {
      referalCodeController.text =
          box.get(TempFieldToRegistrtAttorneyConstant.referalCode);
    }

    if (box.get(TempFieldToRegistrtAttorneyConstant.country) != null) {
      var id = int.parse(box.get(TempFieldToRegistrtAttorneyConstant.country));
      selectedCountry = Country(
        id: id,
        flagImage: listOfCountries.value
            .firstWhere((element) => element.id == id)
            .flagImage,
        name: listOfCountries.value
            .firstWhere((element) => element.id == id)
            .name,
        currency: listOfCountries.value
            .firstWhere((element) => element.id == id)
            .currency,
        dialCode: listOfCountries.value
            .firstWhere((element) => element.id == id)
            .dialCode,
        maxLength: listOfCountries.value
            .firstWhere((element) => element.id == id)
            .maxLength,
        minLength: listOfCountries.value
            .firstWhere((element) => element.id == id)
            .minLength,
      );

      country = selectedCountry;

      countryCode = listOfCountries.value
              .firstWhere((element) => element.id == id)
              .dialCode ??
          "";
      countryController.text = listOfCountries.value
              .firstWhere((element) => element.id == id)
              .name ??
          "";
    }
    loadingStatusController.sink.add(LoadingStatus.finish);
  }

  validateFieldsForFaze1() {
    enableNextBtn.sink.add(false);

    if (suffixNameController.text.isNotEmpty &&
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        genderController.text.isNotEmpty &&
        countryController.text.isNotEmpty &&
        selectedDate != null &&
        validatePhoneNumber &&
        mobileNumberErrorMessage.value == false &&
        mobileController.isNotEmpty &&
        profileImage != null &&
        iDImage != null) {
      enableNextBtn.sink.add(true);
    }
  }

  validateMobileNumber(String fullMobileNumber) {
    service.validateMobileNumber(fullMobileNumber).then((value) {
      mobileNumberErrorMessage.value = value;
      validateFieldsForFaze1();
    });
  }

  Country returnSelectedCountryFromDatabase() {
    countryCode = box.get(DatabaseFieldConstant.selectedCountryDialCode);
    country = Country(
      id: int.parse(box.get(DatabaseFieldConstant.selectedCountryId)),
      flagImage: box.get(DatabaseFieldConstant.selectedCountryFlag),
      name: box.get(DatabaseFieldConstant.selectedCountryName),
      currency: box.get(DatabaseFieldConstant.selectedCountryCurrency),
      dialCode: box.get(DatabaseFieldConstant.selectedCountryDialCode),
      maxLength:
          int.parse(box.get(DatabaseFieldConstant.selectedCountryMaxLenght)),
      minLength:
          int.parse(box.get(DatabaseFieldConstant.selectedCountryMinLenght)),
    );
    return country!;
  }

  void getlistOfSuffix() {
    loadingStatusController.sink.add(LoadingStatus.inprogress);
    service.suffix().then((value) {
      listOfSuffix.value = value.data!..sort((a, b) => a.id!.compareTo(b.id!));
      loadingStatusController.sink.add(LoadingStatus.finish);
    });
  }

  void getlistOfCountries() {
    loadingStatusController.sink.add(LoadingStatus.inprogress);
    service.countries().then((value) {
      listOfCountries.value = value.data!
        ..sort((a, b) => a.id!.compareTo(b.id!));

      tryToFillTheFields();
    });
  }

  void validateReferal(String code) {
    service.validateReferalCode(code).then((value) {
      validateReferalCode.value = value;
    });
  }

  @override
  onDispose() {}
}
