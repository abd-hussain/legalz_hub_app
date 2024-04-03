class CustomerAccountInfo {
  CustomerAccountInfoData? data;
  String? message;

  CustomerAccountInfo({data, message});

  CustomerAccountInfo.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? CustomerAccountInfoData.fromJson(json['data'])
        : null;
    message = json['message'];
  }
}

class CustomerAccountInfoData {
  int? id;
  String? firstName;
  String? lastName;
  String? invitationCode;
  String? profileImg;
  int? points;
  String? mobileNumber;
  String? email;
  int? gender;
  String? dateOfBirth;
  bool? allowNotifications;
  int? countryId;
  String? flagImage;
  String? countryName;
  String? currency;

  CustomerAccountInfoData(
      {this.id,
      this.firstName,
      this.lastName,
      this.invitationCode,
      this.profileImg,
      this.points,
      this.mobileNumber,
      this.email,
      this.gender,
      this.dateOfBirth,
      this.allowNotifications,
      this.countryId,
      this.flagImage,
      this.countryName,
      this.currency});

  CustomerAccountInfoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    invitationCode = json['invitation_code'];
    profileImg = json['profile_img'];
    points = json['points'];
    mobileNumber = json['mobile_number'];
    email = json['email'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    allowNotifications = json['allow_notifications'];
    countryId = json['country_id'];
    flagImage = json['flag_image'];
    countryName = json['country_name'];
    currency = json['currency'];
  }
}
