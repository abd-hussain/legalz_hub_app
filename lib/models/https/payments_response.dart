import 'package:legalz_hub_app/models/model_checker.dart';

class PaymentResponse {
  List<PaymentResponseData>? data;
  String? message;

  PaymentResponse({this.data, this.message});

  PaymentResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(PaymentResponseData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class PaymentResponseData with ModelChecker {
  int? id;
  int? attorneyId;
  int? appointmentId;
  int? paymentStatus;
  String? createdAt;
  String? paymentReportedMessage;
  int? customersId;
  int? appointmentType;
  String? appointmentDateFrom;
  String? appointmentDateTo;
  int? appointmentState;
  bool? appointmentIsFree;
  double? appointmentPrice;
  double? appointmentTotalPrice;
  String? currency;
  double? attorneyHourRate;
  String? noteFromCustomer;
  String? noteFromAttorney;
  int? appointmentDiscountId;
  String? customerFirstName;
  String? customerLastName;
  String? customerProfileImg;
  int? customerCountryId;
  String? customerFlagImg;

  PaymentResponseData({
    this.id,
    this.attorneyId,
    this.appointmentId,
    this.paymentStatus,
    this.createdAt,
    this.paymentReportedMessage,
    this.customersId,
    this.appointmentType,
    this.appointmentDateFrom,
    this.appointmentDateTo,
    this.appointmentState,
    this.appointmentIsFree,
    this.appointmentPrice,
    this.appointmentTotalPrice,
    this.currency,
    this.attorneyHourRate,
    this.noteFromCustomer,
    this.noteFromAttorney,
    this.appointmentDiscountId,
    this.customerFirstName,
    this.customerLastName,
    this.customerProfileImg,
    this.customerCountryId,
    this.customerFlagImg,
  });

  PaymentResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attorneyId = json['attorney_id'];
    appointmentId = json['appointment_id'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    paymentReportedMessage = json['payment_reported_message'];
    customersId = json['customers_id'];
    appointmentType = json['appointment_type'];
    appointmentDateFrom = json['appointment_date_from'];
    appointmentDateTo = json['appointment_date_to'];
    appointmentState = json['appointment_state'];
    appointmentIsFree = json['appointment_is_free'];
    appointmentPrice = convertToDouble(json['appointment_price']);
    appointmentTotalPrice = convertToDouble(json['appointment_total_price']);
    currency = json['currency'];
    attorneyHourRate = convertToDouble(json['attorney_hour_rate']);
    noteFromCustomer = json['note_from_customers'];
    noteFromAttorney = json['note_from_attorney'];
    appointmentDiscountId = json['appointment_discount_id'];
    customerFirstName = json['customer_first_name'];
    customerLastName = json['customer_last_name'];
    customerProfileImg = json['customer_profile_img'];
    customerCountryId = json['customer_country_id'];
    customerFlagImg = json['customer_flag_img'];
  }
}
