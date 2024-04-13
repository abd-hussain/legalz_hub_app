import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/locator.dart';
import 'package:legalz_hub_app/models/https/attorney_appointment.dart';
import 'package:legalz_hub_app/models/https/categories_model.dart';
import 'package:legalz_hub_app/models/https/customer_appointment.dart';
import 'package:legalz_hub_app/services/attorney/attorney_appointments_service.dart';
import 'package:legalz_hub_app/services/customer/customer_appointments_service.dart';
import 'package:legalz_hub_app/services/filter_services.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/mixins.dart';

class CallBloc extends Bloc<FilterService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);
  UserType userType = UserType.customer;

  final ValueNotifier<List<AttorneyAppointmentsData>>
      activeAttorneyAppointmentsListNotifier =
      ValueNotifier<List<AttorneyAppointmentsData>>([]);

  final ValueNotifier<List<CustomerAppointmentData>>
      activeCustomerAppointmentsListNotifier =
      ValueNotifier<List<CustomerAppointmentData>>([]);

  void getActiveAppointments() {
    if (userType == UserType.attorney) {
      locator<AttorneyAppointmentsService>()
          .getActiveAttorneyAppointments()
          .then((value) {
        if (value.data != null) {
          activeAttorneyAppointmentsListNotifier.value =
              _handleAttorneyTimingFromUTC(value.data!);
        }
      });
    } else {
      locator<CustomerAppointmentsService>()
          .getClientActiveAppointments()
          .then((value) {
        if (value.data != null) {
          activeCustomerAppointmentsListNotifier.value =
              _handleCustomerTimingFromUTC(value.data!);
        }
      });
    }
  }

  List<AttorneyAppointmentsData> _handleAttorneyTimingFromUTC(
      List<AttorneyAppointmentsData> data) {
    int offset = DateTime.now().timeZoneOffset.inHours;

    for (var appoint in data) {
      appoint.dateFrom = _adjustDate(appoint.dateFrom, offset);
      appoint.dateTo = _adjustDate(appoint.dateTo, offset);
    }

    return data;
  }

  List<CustomerAppointmentData> _handleCustomerTimingFromUTC(
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

  bool isTimeDifferencePositive(DateTime timeDifference) {
    return timeDifference.hour > 0 ||
        timeDifference.minute > 0 ||
        timeDifference.second > 0;
  }

  AttorneyAppointmentsData? getNearestAttorneyMeetingToday(
      List<AttorneyAppointmentsData> activeMeetings) {
    final now = DateTime.now();

    var removeOldMeetingFromTheList = activeMeetings
        .where((meeting) => DateTime.parse(meeting.dateTo!).isAfter(now))
        .toList();

    var filtermeetingavaliablewithing24Hour = removeOldMeetingFromTheList
        .where((meeting) => DateTime.parse(meeting.dateFrom!)
            .isBefore(now.add(const Duration(hours: 24))))
        .toList();

    return filtermeetingavaliablewithing24Hour.isNotEmpty
        ? filtermeetingavaliablewithing24Hour.reduce((closest, current) =>
            DateTime.parse(current.dateFrom!)
                    .isBefore(DateTime.parse(closest.dateFrom!))
                ? current
                : closest)
        : null;
  }

  CustomerAppointmentData? getNearestCustomerMeetingToday(
      List<CustomerAppointmentData> activeMeetings) {
    final now = DateTime.now();

    var removeOldMeetingFromTheList = activeMeetings
        .where((meeting) => DateTime.parse(meeting.dateTo!).isAfter(now))
        .toList();

    var filtermeetingavaliablewithing24Hour = removeOldMeetingFromTheList
        .where((meeting) => DateTime.parse(meeting.dateFrom!)
            .isBefore(now.add(const Duration(hours: 24))))
        .toList();

    return filtermeetingavaliablewithing24Hour.isNotEmpty
        ? filtermeetingavaliablewithing24Hour.reduce((closest, current) =>
            DateTime.parse(current.dateFrom!)
                    .isBefore(DateTime.parse(closest.dateFrom!))
                ? current
                : closest)
        : null;
  }

  bool chechIfUserNotExiedTheTimeAllowedToEnter(
      {required DateTime appointmentFromDate}) {
    final currentDate = DateTime.now();
    final difference = currentDate.difference(appointmentFromDate).inMinutes;
    return difference < 10;
  }

  Future<List<Category>?> listOfCategories() async {
    final api = await service.categories();
    if (api.data != null) {
      return api.data!..sort((a, b) => a.id!.compareTo(b.id!));
    }
    return null;
  }

  Future<void> cancelAppointment({required int id}) async {
    if (userType == UserType.attorney) {
      return locator<AttorneyAppointmentsService>().cancelAppointment(id: id);
    } else {
      return locator<CustomerAppointmentsService>().cancelAppointment(id: id);
    }
  }

  @override
  onDispose() {}
}
