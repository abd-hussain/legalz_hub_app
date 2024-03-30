import 'dart:io';

class UpdateAccountRequest {
  String suffix;
  String firstName;
  String lastName;
  int gender;
  int countryId;
  List<String> speackingLanguage;
  File? profileImage;
  File? iDImage;
  String dateOfBirth;
  String bio;

  UpdateAccountRequest({
    required this.suffix,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.countryId,
    required this.speackingLanguage,
    required this.profileImage,
    required this.iDImage,
    required this.dateOfBirth,
    required this.bio,
  });
}

class UpdateAccountExperianceRequest {
  String? experienceSince;
  List<int>? majors;
  File? cv;
  File? cert1;
  File? cert2;
  File? cert3;
  int? categoryId;

  UpdateAccountExperianceRequest({
    required this.experienceSince,
    required this.majors,
    this.cv,
    this.cert1,
    this.cert2,
    this.cert3,
    required this.categoryId,
  });
}
