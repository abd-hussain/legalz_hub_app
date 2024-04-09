import 'package:legalz_hub_app/utils/constants/constant.dart';

class CountriesModel {
  List<Country>? data;
  String? message;

  CountriesModel({this.data, this.message});

  CountriesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Country>[];
      json['data'].forEach((v) {
        data!.add(Country.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class Country {
  int? id;
  String? flagImage;
  String? name;
  String? currency;
  String? dialCode;
  String? countryCode;
  String? currencyCode;
  int? minLength;
  int? maxLength;

  Country(
      {this.id,
      this.flagImage,
      this.name,
      this.currency,
      this.dialCode,
      this.countryCode,
      this.currencyCode,
      this.maxLength,
      this.minLength});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    flagImage = AppConstant.imagesBaseURLForCountries + json['flag_image'];
    name = json['name'];
    currency = json['currency'];
    dialCode = json['dialCode'];
    countryCode = json['country_code'];
    currencyCode = json['currency_code'];
    minLength = json['minLength'];
    maxLength = json['maxLength'];
  }
}
