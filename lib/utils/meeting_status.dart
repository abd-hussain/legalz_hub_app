import 'package:legalz_hub_app/models/https/attorney_appointment.dart';

class MeetingStatus {
  AppointmentsState handleMeetingState(int index) {
    if (index == 1) {
      return AppointmentsState.active;
    } else if (index == 2) {
      return AppointmentsState.attorneyCancel;
    } else if (index == 3) {
      return AppointmentsState.customerCancel;
    } else if (index == 4) {
      return AppointmentsState.customerMiss;
    } else if (index == 5) {
      return AppointmentsState.attorneyMiss;
    } else {
      return AppointmentsState.completed;
    }
  }
}
