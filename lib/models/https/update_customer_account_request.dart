import 'dart:io';

class UpdateCustomerAccountRequest {
  UpdateCustomerAccountRequest({
    this.firstName,
    this.lastName,
    this.email,
    this.referalCode,
    this.gender,
    this.countryId,
    this.dateOfBirth,
    this.profileImage,
  });
  String? firstName;
  String? lastName;
  String? email;
  String? referalCode;
  int? gender;
  int? countryId;
  String? dateOfBirth;
  File? profileImage;
}
