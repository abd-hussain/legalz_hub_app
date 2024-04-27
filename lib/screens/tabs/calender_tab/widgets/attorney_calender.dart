import 'package:flutter/material.dart';
import 'package:legalz_hub_app/models/https/attorney_appointment.dart';
import 'package:legalz_hub_app/models/https/note_appointment_request.dart';
import 'package:legalz_hub_app/screens/tabs/calender_tab/widgets/bottom_sheet/main_bottom_sheet.dart';
import 'package:legalz_hub_app/screens/tabs/calender_tab/widgets/bottom_sheet/note_botom_sheet.dart';
import 'package:legalz_hub_app/screens/tabs/calender_tab/widgets/datasource/attorney_datasource.dart';
import 'package:legalz_hub_app/shared_widget/booking/cancel_booking_bottom_sheet.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/gender_format.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AttorneyCalenderView extends StatelessWidget {
  const AttorneyCalenderView({
    required this.language,
    required this.valueNotifier,
    super.key,
    required this.cancelMeeting,
    required this.addNote,
  });
  final String language;
  final ValueNotifier<List<AttorneyAppointmentsData>> valueNotifier;
  final Function(int) cancelMeeting;
  final Function(NoteAppointmentRequest) addNote;

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
              showAgenda: true,
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

                final bottomSheet = MainCalenderBottomSheetsUtil(
                  context: context,
                  language: language,
                  meetingState: item.state,
                  appointmentType: item.appointmentType,
                  dateFrom: item.dateFrom,
                  dateTo: item.dateTo,
                  suffixeName: "",
                  firstName: item.firstName,
                  lastName: item.lastName,
                  profileImg: item.profileImg,
                  dateOfBirth: item.dateOfBirth,
                  userType: UserType.customer,
                  categoryName: "",
                  flagImage: item.flagImage,
                  gender: GenderFormat()
                      .convertIndexToString(context, item.gender!),
                  noteFromCustomer: item.noteFromCustomer ?? "",
                  noteFromAttorney: item.noteFromAttorney ?? "",
                  price: item.price,
                  totalPrice: item.totalPrice,
                  currency: language == "en"
                      ? item.currencyEnglish!
                      : item.currencyArabic!,
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
                            note: item.noteFromAttorney ?? "",
                            confirm: (note) {
                              final body = NoteAppointmentRequest(
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
