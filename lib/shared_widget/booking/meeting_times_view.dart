import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/models/https/attorney_appoitments_response.dart';
import 'package:legalz_hub_app/shared_widget/booking/cell_of_booking.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/utils/day_time.dart';

class MeetingTimeView extends StatelessWidget {
  final List<int> workingHours;

  final ValueNotifier<int?> selectedMeetingTime;
  final DateTime selectedMeetingDate;
  final List<AttorneyAppointmentsResponseData> listOfAppointments;
  const MeetingTimeView({
    super.key,
    required this.workingHours,
    required this.selectedMeetingTime,
    required this.listOfAppointments,
    required this.selectedMeetingDate,
  });

  @override
  Widget build(BuildContext context) {
    List<int> list = workingHours;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    if (DateTime(selectedMeetingDate.year, selectedMeetingDate.month,
            selectedMeetingDate.day) ==
        today) {
      list = filterListWithCurrentTime(list);
    }

    list = _chackifTheDateSelectedExsistInAppotmentsList(
        selectedDateTime: selectedMeetingDate, workingHours: list);

    return SizedBox(
      height: 200,
      child: list.isEmpty
          ? Center(
              child: CustomText(
                title: AppLocalizations.of(context)!.noavaliabletime,
                textColor: const Color(0xff444444),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          : avaliableTimesView(
              context,
              list,
            ),
    );
  }

  Widget avaliableTimesView(BuildContext context, List<int> list) {
    return ValueListenableBuilder<int?>(
        valueListenable: selectedMeetingTime,
        builder: (context, snapshot, child) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisExtent: 50),
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return BookingCell(
                title: DayTime().convertingTimingToRealTime(list[index]),
                isSelected: (snapshot ?? false) == list[index],
                onPress: () {
                  selectedMeetingTime.value = list[index];
                },
              );
            },
          );
        });
  }

  List<int> filterListWithCurrentTime(List<int> list) {
    List<int> filteredList = [];
    int currentHour = DateTime.now().hour;
    for (int time in list) {
      if (time > currentHour) {
        filteredList.add(time);
      }
    }
    return filteredList;
  }

  List<int> _chackifTheDateSelectedExsistInAppotmentsList(
      {required DateTime selectedDateTime, required List<int> workingHours}) {
    List<int> newListOFHours = [];
    List<int> listOfAppointments = _returnListOfHourFromAppointment();

    for (int hour in workingHours) {
      if (listOfAppointments.contains(hour) == false) {
        newListOFHours.add(hour);
      }
    }

    return newListOFHours;
  }

  List<int> _returnListOfHourFromAppointment() {
    List<int> newListOFHours = [];

    for (var appointment in listOfAppointments) {
      var parsedDateFrom = DateTime.parse(appointment.dateFrom!);
      if (DateTime(selectedMeetingDate.year, selectedMeetingDate.month,
              selectedMeetingDate.day) ==
          DateTime(
              parsedDateFrom.year, parsedDateFrom.month, parsedDateFrom.day)) {
        newListOFHours.add(parsedDateFrom.hour);
      }
    }

    return newListOFHours;
  }
}
