import 'package:legalz_hub_app/models/model_checker.dart';

class HourRateResponse {
  HourRateResponse({this.data, this.message});

  HourRateResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? HourRateResponseData.fromJson(json['data'])
        : null;
    message = json['message'];
  }
  HourRateResponseData? data;
  String? message;
}

class HourRateResponseData with ModelChecker {
  HourRateResponseData(
      {this.hourRate, this.iban, this.currency, this.freeCall});

  HourRateResponseData.fromJson(Map<String, dynamic> json) {
    hourRate = convertToDouble(json['hour_rate']);
    iban = json['iban'];
    currency = json['currency'];
    freeCall = json['free_call'];
  }
  double? hourRate;
  String? iban;
  String? currency;
  int? freeCall;
}
