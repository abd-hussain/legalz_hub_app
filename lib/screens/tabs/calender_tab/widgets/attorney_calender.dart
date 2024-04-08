import 'package:flutter/material.dart';
import 'package:legalz_hub_app/models/https/attorney_appointment.dart';
import 'package:legalz_hub_app/screens/tabs/calender_tab/widgets/attorney_datasource.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AttorneyCalenderView extends StatelessWidget {
  final ValueNotifier<List<AttorneyAppointmentsData>> valueNotifier;
  const AttorneyCalenderView({required this.valueNotifier, super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<AttorneyAppointmentsData>>(
        valueListenable: valueNotifier,
        builder: (context, snapshot, child) {
          return SfCalendar(
            view: CalendarView.month,
            firstDayOfWeek: 6,
            allowAppointmentResize: true,
            initialSelectedDate: DateTime.now(),
            todayHighlightColor: const Color(0xff292929),
            dataSource: AttorneyDataSource(context, snapshot),
            monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
              showAgenda: true,
              numberOfWeeksInView: 6,
              appointmentDisplayCount: 10,
              agendaStyle: AgendaStyle(
                backgroundColor: Color(0xffE8E8E8),
                dayTextStyle: TextStyle(fontSize: 16, color: Colors.black),
                dateTextStyle: TextStyle(fontSize: 25, color: Colors.black),
                placeholderTextStyle:
                    TextStyle(fontSize: 25, color: Colors.grey),
              ),
            ),
            onTap: (calendarTapDetails) {
              if (calendarTapDetails.appointments != null &&
                  calendarTapDetails.targetElement ==
                      CalendarElement.appointment) {
                final item = calendarTapDetails.appointments![0]
                    as AttorneyAppointmentsData;
                //TODO
              }
            },
          );
        });
  }
}
