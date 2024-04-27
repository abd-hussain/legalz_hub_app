import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/models/https/attorney_appoitments_response.dart';
import 'package:legalz_hub_app/shared_widget/booking/schadual_booking_bottom_sheet.dart';
import 'package:legalz_hub_app/shared_widget/custom_button.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/utils/currency.dart';

class AttorneyProfileFooterView extends StatelessWidget {
  const AttorneyProfileFooterView({
    required this.currency,
    required this.hourRate,
    super.key,
    required this.freeCall,
    required this.workingHoursSaturday,
    required this.workingHoursSunday,
    required this.workingHoursMonday,
    required this.workingHoursTuesday,
    required this.workingHoursWednesday,
    required this.workingHoursThursday,
    required this.workingHoursFriday,
    required this.listOfAppointments,
    required this.openBookingView,
  });
  final String currency;
  final double hourRate;
  final bool freeCall;
  final List<int>? workingHoursSaturday;
  final List<int>? workingHoursSunday;
  final List<int>? workingHoursMonday;
  final List<int>? workingHoursTuesday;
  final List<int>? workingHoursWednesday;
  final List<int>? workingHoursThursday;
  final List<int>? workingHoursFriday;
  final List<AttorneyAppointmentsResponseData> listOfAppointments;
  final Function(
    Timing selectedMeetingDuration,
    DateTime selectedMeetingDate,
    int selectedMeetingTime,
  ) openBookingView;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffE4E9EF),
      height: 100,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Row(
          children: [
            CustomText(
              title: Currency().calculateHourRate(hourRate, Timing.halfHour, currency, false),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              textColor: const Color(0xff034061),
            ),
            const SizedBox(width: 5),
            const CustomText(
              title: "/",
              fontSize: 18,
              fontWeight: FontWeight.bold,
              textColor: Color(0xff034061),
            ),
            const SizedBox(width: 5),
            CustomText(
              title: "30 ${AppLocalizations.of(context)!.min}",
              fontSize: 18,
              fontWeight: FontWeight.bold,
              textColor: const Color(0xff034061),
            ),
            const Expanded(child: SizedBox()),
            CustomButton(
              enableButton: true,
              width: MediaQuery.of(context).size.width * 0.3,
              buttonTitle: AppLocalizations.of(context)!.booknow,
              onTap: () async {
                await SchaduleBookingBottomSheetsUtil().bookMeetingBottomSheet(
                  context: context,
                  hourRate: hourRate,
                  freeCall: freeCall,
                  currency: currency,
                  workingHoursSaturday: workingHoursSaturday,
                  workingHoursSunday: workingHoursSunday,
                  workingHoursMonday: workingHoursMonday,
                  workingHoursTuesday: workingHoursTuesday,
                  workingHoursWednesday: workingHoursWednesday,
                  workingHoursThursday: workingHoursThursday,
                  workingHoursFriday: workingHoursFriday,
                  listOfAppointments: listOfAppointments,
                  onEndSelection: openBookingView,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
