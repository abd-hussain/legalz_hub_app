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
  int? mentorId;
  int? appointmentId;
  int? paymentStatus;
  String? createdAt;
  String? paymentReportedMessage;
  int? clientId;
  int? appointmentType;
  String? appointmentDateFrom;
  String? appointmentDateTo;
  int? appointmentState;
  bool? appointmentIsFree;
  double? appointmentPrice;
  double? appointmentTotalPrice;
  String? currency;
  double? mentorHourRate;
  String? noteFromClient;
  String? noteFromMentor;
  int? appointmentDiscountId;
  String? clientFirstName;
  String? clientLastName;
  String? clientProfileImg;
  int? clientCountryId;
  String? clientFlagImg;

  PaymentResponseData({
    this.id,
    this.mentorId,
    this.appointmentId,
    this.paymentStatus,
    this.createdAt,
    this.paymentReportedMessage,
    this.clientId,
    this.appointmentType,
    this.appointmentDateFrom,
    this.appointmentDateTo,
    this.appointmentState,
    this.appointmentIsFree,
    this.appointmentPrice,
    this.appointmentTotalPrice,
    this.currency,
    this.mentorHourRate,
    this.noteFromClient,
    this.noteFromMentor,
    this.appointmentDiscountId,
    this.clientFirstName,
    this.clientLastName,
    this.clientProfileImg,
    this.clientCountryId,
    this.clientFlagImg,
  });

  PaymentResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mentorId = json['mentor_id'];
    appointmentId = json['appointment_id'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    paymentReportedMessage = json['payment_reported_message'];
    clientId = json['client_id'];
    appointmentType = json['appointment_type'];
    appointmentDateFrom = json['appointment_date_from'];
    appointmentDateTo = json['appointment_date_to'];
    appointmentState = json['appointment_state'];
    appointmentIsFree = json['appointment_is_free'];
    appointmentPrice = convertToDouble(json['appointment_price']);
    appointmentTotalPrice = convertToDouble(json['appointment_total_price']);
    currency = json['currency'];
    mentorHourRate = convertToDouble(json['mentor_hour_rate']);
    noteFromClient = json['note_from_client'];
    noteFromMentor = json['note_from_mentor'];
    appointmentDiscountId = json['appointment_discount_id'];
    clientFirstName = json['client_first_name'];
    clientLastName = json['client_last_name'];
    clientProfileImg = json['client_profile_img'];
    clientCountryId = json['client_country_id'];
    clientFlagImg = json['client_flag_img'];
  }
}
