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
      loadingStatusController.sink.add(LoadingStatus.finish);
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
