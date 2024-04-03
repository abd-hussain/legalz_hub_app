import 'package:legalz_hub_app/models/model_checker.dart';

class DiscountModel {
  DiscountModelData? data;
  String? message;

  DiscountModel({this.data, this.message});

  DiscountModel.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? DiscountModelData.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class DiscountModelData with ModelChecker {
  int? id;
  String? code;
  double? percentValue;

  DiscountModelData({this.id, this.code, this.percentValue});

  DiscountModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    percentValue = convertToDouble(json['percent_value']);
  }
}
