import 'package:legalz_hub_app/models/model_checker.dart';

class EventDetails {
  EventDetailsData? data;
  String? message;

  EventDetails({this.data, this.message});

  EventDetails.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? EventDetailsData.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class EventDetailsData with ModelChecker {
  String? image;
  int? ownerId;
  String? description;
  int? maxNumberOfAttendance;
  String? dateTo;
  int? state;
  int? id;
  String? title;
  int? joiningClients;
  String? dateFrom;
  double? price;
  String? categoryName;
  String? mentorProfileImg;
  String? mentorSuffixName;
  String? mentorFirstName;
  String? mentorLastName;
  int? mentorId;

  EventDetailsData({
    this.image,
    this.ownerId,
    this.description,
    this.maxNumberOfAttendance,
    this.dateTo,
    this.state,
    this.id,
    this.title,
    this.joiningClients,
    this.dateFrom,
    this.price,
    this.categoryName,
    this.mentorProfileImg,
    this.mentorSuffixName,
    this.mentorFirstName,
    this.mentorLastName,
    this.mentorId,
  });

  EventDetailsData.fromJson(Map<String, dynamic> json) {
    image = convertToString(json['image']);
    ownerId = convertToInteger(json['owner_id']);
    description = convertToString(json['description']);
    maxNumberOfAttendance = convertToInteger(json['max_number_of_attendance']);
    dateTo = convertToString(json['date_to']);
    id = convertToInteger(json['id']);
    state = convertToInteger(json['state']);
    title = convertToString(json['title']);
    joiningClients = convertToInteger(json['joining_clients']);
    dateFrom = convertToString(json['date_from']);
    price = convertToDouble(json['price']);
    categoryName = convertToString(json['category_name']);
    mentorProfileImg = convertToString(json['profile_img']);
    mentorSuffixName = convertToString(json['suffixe_name']);
    mentorFirstName = convertToString(json['first_name']);
    mentorLastName = convertToString(json['last_name']);
    mentorId = convertToInteger(json['owner_id']);
  }
}
