import 'package:legalz_hub_app/models/model_checker.dart';

class CustomerAppointment {
  CustomerAppointment({this.data, this.message});
  CustomerAppointment.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CustomerAppointmentData>[];
      json['data'].forEach((v) {
        data!.add(CustomerAppointmentData.fromJson(v));
      });
    }
    message = json['message'];
  }
  List<CustomerAppointmentData>? data;
  String? message;
}

class CustomerAppointmentData with ModelChecker {
  CustomerAppointmentData(
      {this.id,
      this.dateFrom,
      this.dateTo,
      this.attorneyId,
      this.appointmentType,
      this.state,
      this.discountId,
      this.isFree,
      this.price,
      this.totalPrice,
      this.currency,
      this.attorneyHourRate,
      this.noteFromCustomer,
      this.noteFromAttorney,
      this.channelId,
      this.profileImg,
      this.suffixeName,
      this.firstName,
      this.lastName,
      this.speakingLanguage,
      this.countryName,
      this.categoryName,
      this.gender,
      this.flagImage});

  CustomerAppointmentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateFrom = json['date_from'];
    dateTo = json['date_to'];
    attorneyId = json['attorney_id'];
    appointmentType = json['appointment_type'];
    state = json['state'];
    discountId = json['discount_id'];
    isFree = json['is_free'];
    price = convertToDouble(json['price']);
    totalPrice = convertToDouble(json['total_price']);
    currency = json['currency'];
    attorneyHourRate = convertToDouble(json['attorney_hour_rate']);
    noteFromCustomer = convertToString(json['note_from_customers']);
    noteFromAttorney = convertToString(json['note_from_attorney']);
    channelId = json['channel_id'];
    profileImg = json['profile_img'];
    suffixeName = json['suffixe_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    speakingLanguage = json['speaking_language'].cast<String>();
    countryName = json['countryName'];
    categoryName = json['categoryName'];
    gender = json['gender'];
    flagImage = json['flag_image'];
  }
  int? id;
  String? dateFrom;
  String? dateTo;
  int? attorneyId;
  int? appointmentType;
  int? state;
  int? discountId;
  bool? isFree;
  double? price;
  double? totalPrice;
  String? currency;
  double? attorneyHourRate;
  String? noteFromCustomer;
  String? noteFromAttorney;
  String? channelId;
  String? profileImg;
  String? suffixeName;
  String? firstName;
  String? lastName;
  List<String>? speakingLanguage;
  String? countryName;
  String? categoryName;
  String? flagImage;
  int? gender;
}
