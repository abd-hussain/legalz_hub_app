import 'package:legalz_hub_app/models/model_checker.dart';

enum AppointmentsState {
  active,
  attorneyCancel,
  customerCancel,
  customerMiss,
  attorneyMiss,
  completed
}

class AttorneyAppointments {
  AttorneyAppointments({this.data, this.message});

  AttorneyAppointments.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AttorneyAppointmentsData>[];
      json['data'].forEach((v) {
        data!.add(AttorneyAppointmentsData.fromJson(v));
      });
    }
    message = json['message'];
  }
  List<AttorneyAppointmentsData>? data;
  String? message;
}

class AttorneyAppointmentsData with ModelChecker {
  AttorneyAppointmentsData({
    this.id,
    this.dateFrom,
    this.dateTo,
    this.customersId,
    this.attorneyId,
    this.appointmentType,
    this.channelId,
    this.noteFromAttorney,
    this.noteFromCustomer,
    this.price,
    this.totalPrice,
    this.state,
    this.attorneyJoinCall,
    this.customerJoinCall,
    this.attorneyDateOfClose,
    this.customerDateOfClose,
    this.currencyEnglish,
    this.currencyArabic,
    this.isFree,
    this.attorneyHourRate,
    this.discountId,
    this.profileImg,
    this.firstName,
    this.lastName,
    this.gender,
    this.dateOfBirth,
    this.countryId,
    this.flagImage,
  });

  AttorneyAppointmentsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateFrom = convertToString(json['date_from']);
    dateTo = convertToString(json['date_to']);
    customersId = json['customers_id'];
    attorneyId = json['attorney_id'];
    appointmentType = json['appointment_type'];
    channelId = convertToString(json['channel_id']);
    noteFromAttorney = convertToString(json['note_from_attorney']);
    noteFromCustomer = convertToString(json['note_from_customers']);
    price = convertToDouble(json['price']);
    totalPrice = convertToDouble(json['total_price']);
    state = json['state'];
    attorneyJoinCall = convertToString(json['attorney_join_call']);
    customerJoinCall = convertToString(json['customers_join_call']);
    attorneyDateOfClose = convertToString(json['attorney_date_of_close']);
    customerDateOfClose = convertToString(json['customers_date_of_close']);
    currencyEnglish = json['currency_english'];
    currencyArabic = json['currency_arabic'];
    isFree = json['is_free'];
    attorneyHourRate = convertToDouble(json['attorney_hour_rate']);
    discountId = json['discount_id'];
    profileImg = convertToString(json['profile_img']);
    firstName = convertToString(json['first_name']);
    lastName = convertToString(json['last_name']);
    gender = json['gender'];
    dateOfBirth = convertToString(json['date_of_birth']);
    countryId = json['country_id'];
    flagImage = convertToString(json['flag_image']);
  }
  int? id;
  String? dateFrom;
  String? dateTo;
  int? customersId;
  int? attorneyId;
  int? appointmentType;
  String? channelId;
  String? noteFromAttorney;
  String? noteFromCustomer;
  double? price;
  double? totalPrice;
  int? state;
  String? attorneyJoinCall;
  String? customerJoinCall;
  String? attorneyDateOfClose;
  String? customerDateOfClose;
  String? currencyEnglish;
  String? currencyArabic;
  bool? isFree;
  double? attorneyHourRate;
  int? discountId;
  String? profileImg;
  String? firstName;
  String? lastName;
  int? gender;
  String? dateOfBirth;
  int? countryId;
  String? flagImage;
}
