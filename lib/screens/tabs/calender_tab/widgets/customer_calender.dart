import 'package:flutter/material.dart';
import 'package:legalz_hub_app/models/https/customer_appointment.dart';
import 'package:legalz_hub_app/screens/tabs/calender_tab/widgets/customer_datasource.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CustomerCalenderView extends StatelessWidget {
  final ValueNotifier<List<CustomerAppointmentData>> valueNotifier;
  const CustomerCalenderView({required this.valueNotifier, super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<CustomerAppointmentData>>(
        valueListenable: valueNotifier,
        builder: (context, snapshot, child) {
          return SfCalendar(
            view: CalendarView.month,
            firstDayOfWeek: 6,
            allowAppointmentResize: true,
            initialSelectedDate: DateTime.now(),
            todayHighlightColor: const Color(0xff034061),
            dataSource: CustomerDataSource(context, snapshot),
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
                    as CustomerAppointmentData;
                //TODO
              }
            },
          );
        });
  }
}
