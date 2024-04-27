import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/models/https/attorney_appointment.dart';
import 'package:legalz_hub_app/utils/meeting_status.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AttorneyDataSource extends CalendarDataSource {
  AttorneyDataSource(this.context, List<AttorneyAppointmentsData> source) {
    appointments = source;
  }
  late final BuildContext context;

  @override
  DateTime getStartTime(int index) {
    return DateTime.parse(appointments![index].dateFrom!);
  }

  @override
  DateTime getEndTime(int index) {
    return DateTime.parse(appointments![index].dateTo!);
  }

  @override
  String getSubject(int index) {
    return "${AppLocalizations.of(context)!.meeting} ${AppLocalizations.of(context)!.withword} ${appointments![index].firstName} ${appointments![index].lastName}";
  }

  @override
  Color getColor(int index) {
    if (MeetingStatus().handleMeetingState(appointments![index].state) ==
        AppointmentsState.active) {
      return const Color(0xff006400);
    } else if (MeetingStatus().handleMeetingState(appointments![index].state) ==
        AppointmentsState.completed) {
      return const Color(0xff444444);
    } else {
      return const Color(0xff880808);
    }
  }

  @override
  bool isAllDay(int index) {
    return false;
  }
}
