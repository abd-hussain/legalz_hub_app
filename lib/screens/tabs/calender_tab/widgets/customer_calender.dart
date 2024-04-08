import 'package:flutter/material.dart';
import 'package:legalz_hub_app/models/https/customer_appointment.dart';
import 'package:legalz_hub_app/models/https/note_appointment_request.dart';
import 'package:legalz_hub_app/screens/tabs/calender_tab/widgets/bottom_sheet/main_bottom_sheet.dart';
import 'package:legalz_hub_app/screens/tabs/calender_tab/widgets/bottom_sheet/note_botom_sheet.dart';
import 'package:legalz_hub_app/screens/tabs/calender_tab/widgets/datasource/customer_datasource.dart';
import 'package:legalz_hub_app/shared_widget/cancel_booking_bottom_sheet.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/gender_format.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CustomerCalenderView extends StatelessWidget {
  final String language;
  final ValueNotifier<List<CustomerAppointmentData>> valueNotifier;
  final Function(int) cancelMeeting;
  final Function(NoteAppointmentRequest) addNote;
  const CustomerCalenderView(
      {required this.language,
      required this.valueNotifier,
      super.key,
      required this.cancelMeeting,
      required this.addNote});

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

                final bottomSheet = MainCalenderBottomSheetsUtil(
                  context: context,
                  language: language,
                  meetingState: item.state,
                  appointmentType: item.appointmentType,
                  dateFrom: item.dateFrom,
                  dateTo: item.dateTo,
                  suffixeName: item.suffixeName,
                  firstName: item.firstName,
                  lastName: item.lastName,
                  profileImg: item.profileImg,
                  dateOfBirth: "",
                  userType: UserType.attorney,
                  categoryName: item.categoryName,
                  flagImage: item.flagImage,
                  gender: GenderFormat()
                      .convertIndexToString(context, item.gender!),
                  noteFromCustomer: item.noteFromCustomer ?? "",
                  noteFromAttorney: item.noteFromAttorney ?? "",
                  price: item.price,
                  totalPrice: item.totalPrice,
                  currency: item.currency,
                );

                bottomSheet.bookMeetingBottomSheet(
                  cancel: () {
                    CancelBookingBottomSheetsUtil(context: context)
                        .bookMeetingBottomSheet(
                      confirm: () {
                        cancelMeeting(item.id!);
                      },
                    );
                  },
                  addNote: () {
                    NoteBottomSheetsUtil(context: context)
                        .showAddEditNoteDialog(
                            note: item.noteFromCustomer ?? "",
                            confirm: (note) {
                              var body = NoteAppointmentRequest(
                                  id: item.id!, comment: note);
                              addNote(body);
                            });
                  },
                );
              }
            },
          );
        });
  }
}
