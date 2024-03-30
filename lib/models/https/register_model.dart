class Register {
  final String suffixeName;
  final String firstName;
  final String lastName;
  final String email;
  final String countryId;
  final int gender;
  final String dateOfBirth;
  final String bio;
  final List<int> majors;
  final String categoryId;
  final List<String> speakingLanguage;
  final String? referalCode;
  final String mobileNumber;
  final List<int>? workingHoursSaturday;
  final List<int>? workingHoursSunday;
  final List<int>? workingHoursMonday;
  final List<int>? workingHoursTuesday;
  final List<int>? workingHoursWednesday;
  final List<int>? workingHoursThursday;
  final List<int>? workingHoursFriday;
  final String hourRate;
  final String iban;
  final String password;
  final String appVersion;
  final String? pushToken;
  final String experienceSince;
  final String? profileImg;
  final String? idImg;
  final String? cv;
  final String? cert1;
  final String? cert2;
  final String? cert3;

  Register(
      {required this.suffixeName,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.countryId,
      required this.gender,
      required this.dateOfBirth,
      required this.bio,
      required this.majors,
      required this.categoryId,
      required this.speakingLanguage,
      this.referalCode,
      required this.mobileNumber,
      this.workingHoursSaturday,
      this.workingHoursSunday,
      this.workingHoursMonday,
      this.workingHoursTuesday,
      this.workingHoursWednesday,
      this.workingHoursThursday,
      this.workingHoursFriday,
      required this.hourRate,
      required this.iban,
      required this.password,
      required this.appVersion,
      this.pushToken,
      required this.experienceSince,
      this.profileImg,
      this.idImg,
      this.cv,
      this.cert1,
      this.cert2,
      this.cert3});
}
