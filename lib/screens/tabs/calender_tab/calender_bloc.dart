import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/models/https/attorney_appointment.dart';
import 'package:legalz_hub_app/models/https/customer_appointment.dart';
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

  //TODO

  void getAppointments(BuildContext context) async {}

  // void getMentorAppointments(BuildContext context) async {
  //   await service.getMentorAppointments().then((value) {
  //     if (value.data != null) {
  //       meetingsListNotifier.value = handleTimingFromUTC(value.data!);
  //     }
  //   });
  // }

  // List<AppointmentData> handleTimingFromUTC(List<AppointmentData> data) {
  //   int offset = DateTime.now().timeZoneOffset.inHours;

  //   for (var appoint in data) {
  //     appoint.dateFrom = _adjustDate(appoint.dateFrom, offset);
  //     appoint.dateTo = _adjustDate(appoint.dateTo, offset);
  //   }

  //   return data;
  // }

  // String _adjustDate(String? dateString, int offset) {
  //   if (dateString == null) return '';

  //   final DateTime date = DateTime.parse(dateString);
  //   final DateTime adjustedDate = date.add(Duration(hours: offset));

  //   return adjustedDate.toString();
  // }

  // Future<dynamic> cancelMeeting(int meetingId) async {
  //   return service.cancelAppointment(id: meetingId);
  // }

  // Future<dynamic> addNote(AddCommentToAppointment body) async {
  //   return service.addCommentToAppointment(body: body);
  // }

  // Future<void> getClientAppointments(BuildContext context) async {
  //   await service.getClientAppointments().then((value) {
  //     if (value.data != null) {
  //       meetingsListNotifier.value = handleTimingFromUTC(value.data!);
  //     }
  //   });
  // }

  // List<AppointmentData> handleTimingFromUTC(List<AppointmentData> data) {
  //   int offset = DateTime.now().timeZoneOffset.inHours;

  //   for (var appoint in data) {
  //     appoint.dateFrom = _adjustDate(appoint.dateFrom, offset);
  //     appoint.dateTo = _adjustDate(appoint.dateTo, offset);
  //   }

  //   return data;
  // }

  // String _adjustDate(String? dateString, int offset) {
  //   if (dateString == null) return '';

  //   final DateTime date = DateTime.parse(dateString);
  //   final DateTime adjustedDate = date.add(Duration(hours: offset));

  //   return adjustedDate.toString();
  // }

  // Future<dynamic> cancelMeeting(int meetingId) async {
  //   return locator<AppointmentsService>().cancelAppointment(id: meetingId);
  // }

  // Future<dynamic> editNoteMeeting({required int meetingId, required String note}) async {
  //   return locator<AppointmentsService>().editNoteAppointment(
  //       noteAppointment: NoteAppointmentRequest(
  //     id: meetingId,
  //     comment: note,
  //   ));
  // }
}
