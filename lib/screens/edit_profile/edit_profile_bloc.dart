import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/locator.dart';
import 'package:legalz_hub_app/models/https/countries_model.dart';
import 'package:legalz_hub_app/models/https/suffix_model.dart';
import 'package:legalz_hub_app/models/https/update_attorney_account_request.dart';
import 'package:legalz_hub_app/models/https/update_customer_account_request.dart';
import 'package:legalz_hub_app/models/working_hours.dart';
import 'package:legalz_hub_app/services/attorney/attorney_account_service.dart';
import 'package:legalz_hub_app/services/customer/customer_account_service.dart';
import 'package:legalz_hub_app/services/filter_services.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/loading_status.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/gender_format.dart';

class EditProfileBloc {
  ValueNotifier<LoadingStatus> loadingStatusNotifier = ValueNotifier<LoadingStatus>(LoadingStatus.idle);
  ValueNotifier<bool> enableSaveButtonNotifier = ValueNotifier<bool>(false);
  ValueNotifier<List<Country>> listOfCountriesNotifier = ValueNotifier<List<Country>>([]);
  ValueNotifier<List<CheckBox>> listOfSpeakingLanguageNotifier = ValueNotifier<List<CheckBox>>([]);
  List<String> listOfSpeakingLanguage = [];
  String? selectedDate;

  final box = Hive.box(DatabaseBoxConstant.userInfo);
  TextEditingController suffixNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  TextEditingController genderController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController referalCodeController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  ValueNotifier<List<SuffixData>> listOfSuffix = ValueNotifier<List<SuffixData>>([]);

  String profileImageUrl = "";
  File? profileImage;

  String iDImageUrl = "";
  File? iDImage;

  Country? selectedCountry;

  UserType userType = UserType.customer;

  void validateFields() {
    enableSaveButtonNotifier.value = false;

    if (userType == UserType.attorney) {
      final bool areAllFieldsValid = suffixNameController.text.isNotEmpty &&
          firstNameController.text.isNotEmpty &&
          lastNameController.text.isNotEmpty &&
          (profileImageUrl != "" || profileImage != null) &&
          (iDImageUrl != "" || iDImage != null) &&
          selectedCountry != null &&
          genderController.text != "" &&
          mobileNumberController.text.isNotEmpty &&
          bioController.text.isNotEmpty;

      final bool hasValidLanguage = listOfSpeakingLanguageNotifier.value.any((item) => item.isEnable);

      print("hasValidLanguage $hasValidLanguage");

      if (areAllFieldsValid && hasValidLanguage) {
        enableSaveButtonNotifier.value = true;
      }
    } else {
      final bool areAllFieldsValid = firstNameController.text.isNotEmpty &&
          lastNameController.text.isNotEmpty &&
          selectedCountry != null &&
          genderController.text != "" &&
          mobileNumberController.text.isNotEmpty;

      if (areAllFieldsValid) {
        enableSaveButtonNotifier.value = true;
      }
    }
  }

  Future<void> getProfileInformations(BuildContext context) async {
    loadingStatusNotifier.value = LoadingStatus.inprogress;

    if (userType == UserType.attorney) {
      await locator<FilterService>().suffix().then((value) {
        listOfSuffix.value = value.data!..sort((a, b) => a.id!.compareTo(b.id!));
      });

      await locator<AttorneyAccountService>().getProfileInfo().then((value) {
        final data = value.data;
        if (data != null) {
          suffixNameController.text = data.suffixeName ?? "";
          firstNameController.text = data.firstName ?? "";
          lastNameController.text = data.lastName ?? "";
          emailController.text = data.email ?? "";
          mobileNumberController.text = data.mobileNumber ?? "";
          referalCodeController.text = data.invitationCode ?? "";
          bioController.text = data.bio ?? "";
          profileImageUrl = data.profileImg ?? "";

          iDImageUrl = data.idImg ?? "";
          selectedDate = data.dateOfBirth ?? "";

          if (data.dBCountries != null) {
            final dbCountries = data.dBCountries!;

            selectedCountry = Country(
              id: dbCountries.id ?? 0,
              flagImage: dbCountries.flagImage ?? "",
              name: box.get(DatabaseFieldConstant.language) == "en"
                  ? dbCountries.nameEnglish ?? ""
                  : dbCountries.nameArabic ?? "",
              currency: box.get(DatabaseFieldConstant.language) == "en"
                  ? dbCountries.currencyEnglish ?? ""
                  : dbCountries.currencyArabic ?? "",
              dialCode: dbCountries.dialCode ?? "",
              maxLength: dbCountries.maxLength ?? 0,
              minLength: dbCountries.minLength ?? 0,
            );

            countryController.text = box.get(DatabaseFieldConstant.language) == "en"
                ? dbCountries.nameEnglish ?? ""
                : dbCountries.nameArabic ?? "";
          }

          if (value.data!.gender != null) {
            genderController.text = GenderFormat().convertIndexToString(context, value.data!.gender!);
          }

          if (data.speakingLanguage != null) {
            listOfSpeakingLanguageNotifier.value = _prepareList(data.speakingLanguage!);
          }
        }
        getListOfCountries(context);
      });
    } else {
      await locator<CustomerAccountService>().getCustomerAccountInfo().then((value) {
        final data = value.data;
        if (data != null) {
          firstNameController.text = value.data!.firstName ?? "";
          lastNameController.text = value.data!.lastName ?? "";
          emailController.text = value.data!.email ?? "";
          mobileNumberController.text = value.data!.mobileNumber ?? "";
          referalCodeController.text = value.data!.invitationCode ?? "";

          if (value.data!.gender != null) {
            genderController.text = GenderFormat().convertIndexToString(context, value.data!.gender!);
          }

          profileImageUrl = value.data!.profileImg!;
          selectedDate = data.dateOfBirth ?? "";

          if (data.dBCountries != null) {
            final dbCountries = data.dBCountries!;

            selectedCountry = Country(
              id: dbCountries.id ?? 0,
              flagImage: dbCountries.flagImage ?? "",
              name: box.get(DatabaseFieldConstant.language) == "en"
                  ? dbCountries.nameEnglish ?? ""
                  : dbCountries.nameArabic ?? "",
              currency: box.get(DatabaseFieldConstant.language) == "en"
                  ? dbCountries.currencyEnglish ?? ""
                  : dbCountries.currencyArabic ?? "",
              dialCode: dbCountries.dialCode ?? "",
              maxLength: dbCountries.maxLength ?? 0,
              minLength: dbCountries.minLength ?? 0,
            );

            countryController.text = box.get(DatabaseFieldConstant.language) == "en"
                ? dbCountries.nameEnglish ?? ""
                : dbCountries.nameArabic ?? "";
          }
        }
        getListOfCountries(context);
      });
    }
  }

  void getListOfCountries(BuildContext context) {
    locator<FilterService>().countries().then((value) async {
      listOfCountriesNotifier.value = value.data!..sort((a, b) => a.id!.compareTo(b.id!));
      loadingStatusNotifier.value = LoadingStatus.finish;
    });
  }

  List<CheckBox> _prepareList(List<String> theList) {
    final List<CheckBox> list = [];

    final languagesToCheck = ["English", "العربية", "Français", "Español", "Türkçe"];
    for (final language in languagesToCheck) {
      final isEnable = theList.any((item) => item.contains(language));
      list.add(CheckBox(value: language, isEnable: isEnable));
    }
    return list;
  }

  Future updateProfileInfo(BuildContext context) async {
    if (userType == UserType.attorney) {
      final speackingLanguage =
          listOfSpeakingLanguageNotifier.value.where((item) => item.isEnable).map((item) => item.value).toList();

      final UpdateAttorneyAccountRequest account = UpdateAttorneyAccountRequest(
        suffix: suffixNameController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        profileImage: profileImage,
        iDImage: iDImage,
        countryId: selectedCountry!.id!,
        dateOfBirth: selectedDate!,
        speackingLanguage: speackingLanguage,
        bio: bioController.text,
        gender: GenderFormat().convertStringToIndex(context, genderController.text),
      );
      return locator<AttorneyAccountService>().updateProfileInfo(account: account);
    } else {
      final UpdateCustomerAccountRequest account = UpdateCustomerAccountRequest(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        gender: GenderFormat().convertStringToIndex(context, genderController.text),
        countryId: selectedCountry != null
            ? selectedCountry!.id!
            : int.parse(box.get(DatabaseFieldConstant.selectedCountryId)),
        dateOfBirth: selectedDate,
        profileImage: profileImage,
        referalCode: referalCodeController.text,
      );

      return locator<CustomerAccountService>().updateAccount(account: account);
    }
  }
}
