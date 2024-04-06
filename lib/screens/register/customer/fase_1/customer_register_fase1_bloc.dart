import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/models/https/countries_model.dart';
import 'package:legalz_hub_app/services/filter_services.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/loading_status.dart';
import 'package:legalz_hub_app/utils/mixins.dart';

class CustomerRegister1Bloc extends Bloc<FilterService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController referalCodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  String profileImageUrl = "";
  String? selectedDate;

  File? profileImage;

  Country? selectedCountry;

  ValueNotifier<bool?> validateReferalCode = ValueNotifier<bool?>(null);

  ValueNotifier<List<Country>> listOfCountries =
      ValueNotifier<List<Country>>([]);
  StreamController<LoadingStatus> loadingStatusController =
      StreamController<LoadingStatus>();
  ValueNotifier<bool> mobileNumberErrorMessage = ValueNotifier<bool>(false);

  String countryCode = "";
  Country? country;

  String mobileController = "";
  bool validatePhoneNumber = false;

  StreamController<bool> enableNextBtn = StreamController<bool>();

  tryToFillTheFields() {
    if (box.get(TempFieldToRegistrtCustomerConstant.firstName) != null) {
      firstNameController.text =
          box.get(TempFieldToRegistrtCustomerConstant.firstName);
    }

    if (box.get(TempFieldToRegistrtCustomerConstant.lastName) != null) {
      lastNameController.text =
          box.get(TempFieldToRegistrtCustomerConstant.lastName);
    }

    if (box.get(TempFieldToRegistrtCustomerConstant.country) != null) {
      var id = int.parse(box.get(TempFieldToRegistrtCustomerConstant.country));
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

    if (box.get(TempFieldToRegistrtCustomerConstant.phoneNumber) != null) {
      mobileController = box
          .get(TempFieldToRegistrtCustomerConstant.phoneNumber)
          .replaceAll(countryCode, "");
    }

    if (box.get(TempFieldToRegistrtCustomerConstant.dateOfBirth) != null) {
      selectedDate = box.get(TempFieldToRegistrtCustomerConstant.dateOfBirth);
    }

    if (box.get(TempFieldToRegistrtCustomerConstant.gender) != null) {
      genderController.text =
          box.get(TempFieldToRegistrtCustomerConstant.gender);
    }

    if (box.get(TempFieldToRegistrtCustomerConstant.profileImage) != null) {
      profileImageUrl =
          box.get(TempFieldToRegistrtCustomerConstant.profileImage);
    }

    if (box.get(TempFieldToRegistrtCustomerConstant.referalCode) != null) {
      referalCodeController.text =
          box.get(TempFieldToRegistrtCustomerConstant.referalCode);
    }

    loadingStatusController.sink.add(LoadingStatus.finish);
  }

  validateFieldsForFaze1() {
    enableNextBtn.sink.add(false);

    if (firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        genderController.text.isNotEmpty &&
        countryController.text.isNotEmpty &&
        selectedDate != null &&
        validatePhoneNumber &&
        mobileNumberErrorMessage.value == false &&
        mobileController.isNotEmpty &&
        profileImage != null) {
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

  getlistOfCountries() {
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
