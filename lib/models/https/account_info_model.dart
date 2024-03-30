class AccountInfo {
  AccountInfoData? data;
  String? message;

  AccountInfo({this.data, this.message});

  AccountInfo.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? AccountInfoData.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class AccountInfoData {
  String? profileImg;
  String? mobileNumber;
  String? suffixeName;
  String? dateOfBirth;
  String? firstName;
  String? email;
  String? lastName;
  int? gender;
  List<String>? speakingLanguage;
  int? countryId;
  DBCountries? dBCountries;
  String? invitationCode;
  String? idImg;
  String? bio;

  AccountInfoData(
      {this.profileImg,
      this.mobileNumber,
      this.suffixeName,
      this.dateOfBirth,
      this.firstName,
      this.email,
      this.lastName,
      this.gender,
      this.speakingLanguage,
      this.countryId,
      this.dBCountries,
      this.invitationCode,
      this.idImg,
      this.bio});

  AccountInfoData.fromJson(Map<String, dynamic> json) {
    profileImg = json['profile_img'];
    mobileNumber = json['mobile_number'];
    suffixeName = json['suffixe_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    dateOfBirth = json['date_of_birth'];
    email = json['email'];
    bio = json['bio'];
    gender = json['gender'];
    speakingLanguage = json['speaking_language'].cast<String>();
    countryId = json['country_id'];
    invitationCode = json['invitation_code'];
    idImg = json['id_img'];
    dBCountries = json['DB_Countries'] != null
        ? DBCountries.fromJson(json['DB_Countries'])
        : null;
  }
}

class DBCountries {
  String? flagImage;
  String? currencyArabic;
  String? nameArabic;
  String? dialCode;
  String? createdAt;
  String? nameEnglish;
  int? id;
  String? currencyEnglish;
  bool? published;
  int? minLength;
  int? maxLength;

  DBCountries({
    this.flagImage,
    this.currencyArabic,
    this.nameArabic,
    this.dialCode,
    this.createdAt,
    this.nameEnglish,
    this.id,
    this.currencyEnglish,
    this.published,
    this.minLength,
    this.maxLength,
  });

  DBCountries.fromJson(Map<String, dynamic> json) {
    flagImage = json['flag_image'];
    nameArabic = json['name_arabic'];
    currencyArabic = json['currency_arabic'];
    dialCode = json['dialCode'];
    dialCode = json['dialCode'];
    minLength = json['minLength'];
    published = json['published'];
    id = json['id'];
    nameEnglish = json['name_english'];
    currencyEnglish = json['currency_english'];
    maxLength = json['maxLength'];
    createdAt = json['created_at'];
  }
}
