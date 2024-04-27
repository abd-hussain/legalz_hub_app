import 'package:legalz_hub_app/models/model_checker.dart';

class AttorneyDetailsResponse {
  AttorneyDetailsResponse({this.data, this.message});

  AttorneyDetailsResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? AttorneyDetailsResponseData.fromJson(json['data']) : null;
    message = json['message'];
  }
  AttorneyDetailsResponseData? data;
  String? message;
}

class AttorneyDetailsResponseData with ModelChecker {
  AttorneyDetailsResponseData(
      {this.id,
      this.suffixeName,
      this.firstName,
      this.lastName,
      this.bio,
      this.speakingLanguage,
      this.hourRate,
      this.freeCall,
      this.currency,
      this.currencyCode,
      this.countryCode,
      this.totalRate,
      this.gender,
      this.profileImg,
      this.dateOfBirth,
      this.experienceSince,
      this.categoryName,
      this.categoryID,
      this.country,
      this.countryFlag,
      this.workingHoursSaturday,
      this.workingHoursSunday,
      this.workingHoursMonday,
      this.workingHoursTuesday,
      this.workingHoursWednesday,
      this.workingHoursThursday,
      this.workingHoursFriday,
      this.reviews});

  AttorneyDetailsResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    suffixeName = convertToString(json['suffixe_name']);
    firstName = convertToString(json['first_name']);
    lastName = convertToString(json['last_name']);
    bio = convertToString(json['bio']);
    speakingLanguage = json['speaking_language'].cast<String>();
    hourRate = convertToDouble(json['hour_rate']);
    freeCall = json['free_call'];
    currency = convertToString(json['currency']);
    countryCode = convertToString(json['country_code']);
    currencyCode = convertToString(json['currency_code']);
    totalRate = convertToDouble(json['total_rate']);
    gender = json['gender'];
    profileImg = convertToString(json['profile_img']);
    dateOfBirth = convertToString(json['date_of_birth']);
    experienceSince = convertToString(json['experience_since']);
    categoryName = convertToString(json['category_name']);
    categoryID = json['category_id'];
    country = convertToString(json['country']);
    countryFlag = convertToString(json['country_flag']);
    workingHoursSaturday = json['working_hours_saturday'].cast<int>();
    workingHoursSunday = json['working_hours_sunday'].cast<int>();
    workingHoursMonday = json['working_hours_monday'].cast<int>();
    workingHoursTuesday = json['working_hours_tuesday'].cast<int>();
    workingHoursWednesday = json['working_hours_wednesday'].cast<int>();
    workingHoursThursday = json['working_hours_thursday'].cast<int>();
    workingHoursFriday = json['working_hours_friday'].cast<int>();
    reviews = <Reviews>[];
    json['reviews'].forEach((v) {
      reviews!.add(Reviews.fromJson(v));
    });
  }
  int? id;
  String? suffixeName;
  String? firstName;
  String? lastName;
  int? gender;
  String? bio;
  List<String>? speakingLanguage;
  double? hourRate;
  int? freeCall;
  String? currency;
  String? currencyCode;
  String? countryCode;
  String? profileImg;
  String? dateOfBirth;
  String? experienceSince;
  String? categoryName;
  int? categoryID;
  String? country;
  String? countryFlag;
  double? totalRate;
  List<int>? workingHoursSaturday;
  List<int>? workingHoursSunday;
  List<int>? workingHoursMonday;
  List<int>? workingHoursTuesday;
  List<int>? workingHoursWednesday;
  List<int>? workingHoursThursday;
  List<int>? workingHoursFriday;
  List<Reviews>? reviews;
}

class Reviews with ModelChecker {
  Reviews(
      {this.id,
      this.customerFirstName,
      this.customerLastName,
      this.customerProfileImg,
      this.attorneyId,
      this.stars,
      this.comments,
      this.attorneyResponse,
      this.flagImage,
      this.createdAt});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerFirstName = convertToString(json['customer_first_name']);
    customerLastName = convertToString(json['customer_last_name']);
    customerProfileImg = convertToString(json['customer_profile_img']);
    attorneyId = json['attorney_id'];
    stars = convertToDouble(json['stars']);
    comments = convertToString(json['comments']);
    attorneyResponse = convertToString(json['attorney_response']);
    flagImage = convertToString(json['flag_image']);
    createdAt = convertToString(json['created_at']);
  }
  int? id;
  String? customerFirstName;
  String? customerLastName;
  String? customerProfileImg;
  int? attorneyId;
  double? stars;
  String? comments;
  String? attorneyResponse;
  String? flagImage;
  String? createdAt;
}
