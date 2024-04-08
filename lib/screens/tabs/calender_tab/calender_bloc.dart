import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/locator.dart';
import 'package:legalz_hub_app/models/https/attorney_appointment.dart';
import 'package:legalz_hub_app/models/https/customer_appointment.dart';
import 'package:legalz_hub_app/models/https/note_appointment_request.dart';
import 'package:legalz_hub_app/services/attorney/attorney_appointments_service.dart';
import 'package:legalz_hub_app/services/customer/customer_appointments_service.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';

class CalenderBloc {
  final box = Hive.box(DatabaseBoxConstant.userInfo);
  final ValueNotifier<List<AttorneyAppointmentsData>>
      attorneyAppointmentsListNotifier =
      ValueNotifier<List<AttorneyAppointmentsData>>([]);
  final ValueNotifier<List<CustomerAppointmentData>>
      customerAppointmentsListNotifier =
      ValueNotifier<List<CustomerAppointmentData>>([]);
  UserType userType = UserType.customer;

  void getAppointments(BuildContext context) async {
    if (userType == UserType.attorney) {
      locator<AttorneyAppointmentsService>()
          .getAttorneyAppointments()
          .then((value) {
        if (value.data != null) {
          attorneyAppointmentsListNotifier.value =
              handleAttorneyTimingFromUTC(value.data!);
        }
      });
    } else {
      locator<CustomerAppointmentsService>()
          .getCustomerAppointments()
          .then((value) {
        if (value.data != null) {
          customerAppointmentsListNotifier.value =
              handleCustomerTimingFromUTC(value.data!);
        }
      });
    }
  }

  List<AttorneyAppointmentsData> handleAttorneyTimingFromUTC(
      List<AttorneyAppointmentsData> data) {
    int offset = DateTime.now().timeZoneOffset.inHours;

    for (var appoint in data) {
      appoint.dateFrom = _adjustDate(appoint.dateFrom, offset);
      appoint.dateTo = _adjustDate(appoint.dateTo, offset);
    }

    return data;
  }

  List<CustomerAppointmentData> handleCustomerTimingFromUTC(
      List<CustomerAppointmentData> data) {
    int offset = DateTime.now().timeZoneOffset.inHours;

    for (var appoint in data) {
      appoint.dateFrom = _adjustDate(appoint.dateFrom, offset);
      appoint.dateTo = _adjustDate(appoint.dateTo, offset);
    }

    return data;
  }

  String _adjustDate(String? dateString, int offset) {
    if (dateString == null) return '';

    final DateTime date = DateTime.parse(dateString);
    final DateTime adjustedDate = date.add(Duration(hours: offset));

    return adjustedDate.toString();
  }

  Future<dynamic> customerCancelMeeting(int meetingId) async {
    return locator<CustomerAppointmentsService>()
        .cancelAppointment(id: meetingId);
  }

  Future<dynamic> attorneyCancelMeeting(int meetingId) async {
    return locator<AttorneyAppointmentsService>()
        .cancelAppointment(id: meetingId);
  }

  Future<dynamic> customerEditNoteMeeting(
      {required NoteAppointmentRequest body}) async {
    return locator<CustomerAppointmentsService>()
        .editNoteAppointment(noteAppointment: body);
  }

  Future<dynamic> attorneyEditNoteMeeting(
      {required NoteAppointmentRequest body}) async {
    return locator<AttorneyAppointmentsService>()
        .editNoteAppointment(body: body);
  }
}
