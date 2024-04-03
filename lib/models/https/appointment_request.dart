import 'package:legalz_hub_app/utils/mixins.dart';

class AppointmentRequest implements Model {
  int attorneyId;
  int type;
  bool isFree;
  int payment;
  CustomDate dateFrom;
  CustomDate dateTo;
  String? note;
  int? discountId;
  int? countryId;
  double attorneyHourRate;
  double price;
  double totalPrice;

  AppointmentRequest({
    required this.attorneyId,
    required this.type,
    required this.isFree,
    required this.payment,
    required this.dateFrom,
    required this.dateTo,
    required this.note,
    required this.discountId,
    required this.countryId,
    required this.attorneyHourRate,
    required this.price,
    required this.totalPrice,
  });

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['attorney_id'] = attorneyId;
    data['type'] = type;
    data['payment'] = payment;
    data['is_free'] = isFree;
    data['date_from'] = dateFrom.toJson();
    data['date_to'] = dateTo.toJson();
    data['note'] = note;
    data['discount_id'] = discountId;
    data['country_id'] = countryId;
    data['attorney_hour_rate'] = attorneyHourRate;
    data['price'] = price;
    data['total_price'] = totalPrice;
    return data;
  }
}

class CustomDate {
  int year;
  int month;
  int day;
  int hour;
  int min;

  CustomDate(
      {required this.year,
      required this.month,
      required this.day,
      required this.hour,
      required this.min});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['year'] = year;
    data['month'] = month;
    data['day'] = day;
    data['hour'] = hour;
    data['min'] = min;
    return data;
  }
}
