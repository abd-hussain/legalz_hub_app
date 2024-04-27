class AttorneyAppointmentsResponse {
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
  List<AttorneyAppointmentsResponseData>? data;
  String? message;
}

class AttorneyAppointmentsResponseData {
  AttorneyAppointmentsResponseData({this.dateFrom, this.dateTo});

  AttorneyAppointmentsResponseData.fromJson(Map<String, dynamic> json) {
    dateFrom = json['date_from'];
    dateTo = json['date_to'];
  }
  String? dateFrom;
  String? dateTo;
}
