class AttorneyAppointmentsResponse {
  List<AttorneyAppointmentsResponseData>? data;
  String? message;

  AttorneyAppointmentsResponse({this.data, this.message});

  AttorneyAppointmentsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AttorneyAppointmentsResponseData>[];
      json['data'].forEach((v) {
        data!.add(AttorneyAppointmentsResponseData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class AttorneyAppointmentsResponseData {
  String? dateFrom;
  String? dateTo;

  AttorneyAppointmentsResponseData({this.dateFrom, this.dateTo});

  AttorneyAppointmentsResponseData.fromJson(Map<String, dynamic> json) {
    dateFrom = json['date_from'];
    dateTo = json['date_to'];
  }
}
