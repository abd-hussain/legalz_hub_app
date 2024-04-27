import 'package:legalz_hub_app/utils/constants/constant.dart';

class AttorneyModel {
  AttorneyModel({this.data, this.message});

  AttorneyModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AttorneyModelData>[];
      json['data'].forEach((v) {
        data!.add(AttorneyModelData.fromJson(v));
      });
    }
    message = json['message'];
  }
  List<AttorneyModelData>? data;
  String? message;
}

class AttorneyModelData {
  AttorneyModelData(
      {this.id,
      this.categoryName,
      this.suffixeName,
      this.firstName,
      this.lastName,
      this.gender,
      this.rate,
      this.hourRate,
      this.profileImg,
      this.experianceSince,
      this.languages,
      this.countryName,
      this.countryFlag,
      this.currency,
      this.numberOfReviewers});

  AttorneyModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    suffixeName = json['suffixe_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    hourRate = json['hour_rate'];
    languages = json['languages'].cast<String>();
    profileImg = AppConstant.imagesBaseURLForAttorney + json['profile_img'];
    experianceSince = json['experience_since'];
    countryName = json['country_name'];
    countryFlag = AppConstant.imagesBaseURLForCountries + json['country_flag'];
    rate = json['rate'];
    currency = json['currency'];
    categoryName = json['category_name'];

    numberOfReviewers = json['number_of_reviewers'];
  }
  int? id;
  String? categoryName;
  String? suffixeName;
  String? firstName;
  String? lastName;
  int? gender;
  double? hourRate;
  List<String>? languages;
  String? profileImg;
  String? experianceSince;

  double? rate;
  String? countryName;
  String? countryFlag;
  String? currency;
  int? numberOfReviewers;
}
