class CustomerRegister {
  CustomerRegister({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.countryId,
    required this.gender,
    required this.dateOfBirth,
    this.referalCode,
    required this.mobileNumber,
    required this.password,
    required this.appVersion,
    this.pushToken,
    this.profileImg,
  });
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final String email;
  final String password;
  final int gender;
  final String? referalCode;
  final String? profileImg;
  final String dateOfBirth;
  final String? pushToken;
  final String appVersion;
  final String countryId;
}
