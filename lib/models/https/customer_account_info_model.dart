import 'package:legalz_hub_app/models/https/attorney_account_info_model.dart';

class CustomerAccountInfo {
  CustomerAccountInfo({this.data, this.message});
  CustomerAccountInfo.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? CustomerAccountInfoData.fromJson(json['data'])
        : null;
    message = json['message'];
  }
  CustomerAccountInfoData? data;
  String? message;
}

class CustomerAccountInfoData {
  CustomerAccountInfoData({
    this.firstName,
    this.lastName,
    this.invitationCode,
    this.profileImg,
    this.points,
    this.mobileNumber,
    this.email,
    this.countryId,
    this.gender,
    this.dateOfBirth,
    this.allowNotifications,
    this.dBCountries,
  });

  CustomerAccountInfoData.fromJson(Map<String, dynamic> json) {
    profileImg = json['profile_img'];
    mobileNumber = json['mobile_number'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    dateOfBirth = json['date_of_birth'];
    email = json['email'];
    gender = json['gender'];
    countryId = json['country_id'];
    invitationCode = json['invitation_code'];
    points = json['points'];
    allowNotifications = json['allow_notifications'];
    dBCountries = json['DB_Countries'] != null
        ? DBCountries.fromJson(json['DB_Countries'])
        : null;
  }
  String? firstName;
  String? lastName;
  String? invitationCode;
  String? profileImg;
  int? points;
  String? mobileNumber;
  String? email;
  int? gender;
  int? countryId;
  String? dateOfBirth;
  bool? allowNotifications;
  DBCountries? dBCountries;
}
