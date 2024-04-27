import 'package:legalz_hub_app/models/model_checker.dart';

class DiscountModel {
  DiscountModel({this.data, this.message});

  DiscountModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? DiscountModelData.fromJson(json['data']) : null;
    message = json['message'];
  }
  DiscountModelData? data;
  String? message;
}

class DiscountModelData with ModelChecker {
  DiscountModelData({this.id, this.code, this.percentValue});

  DiscountModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    percentValue = convertToDouble(json['percent_value']);
  }
  int? id;
  String? code;
  double? percentValue;
}
