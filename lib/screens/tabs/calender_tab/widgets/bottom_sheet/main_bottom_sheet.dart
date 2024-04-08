import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:legalz_hub_app/models/https/attorney_appointment.dart';
import 'package:legalz_hub_app/screens/tabs/calender_tab/widgets/other_user_info_view.dart';
import 'package:legalz_hub_app/screens/tabs/calender_tab/widgets/price_view.dart';
import 'package:legalz_hub_app/shared_widget/appointment_details_view.dart';
import 'package:legalz_hub_app/shared_widget/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/utils/day_time.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';

class MainCalenderBottomSheetsUtil {
  final BuildContext context;
  final String language;
  final int? meetingState;
  final int? appointmentType;
  final String? dateFrom;
  final String? dateTo;
  final String? suffixeName;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? profileImg;
  final String? flagImage;
  final String? categoryName;
  final String? dateOfBirth;
  final UserType userType;
  final String? noteFromCustomer;
  final String? noteFromAttorney;
  final String? currency;
  final double? price;
  final double? totalPrice;

  MainCalenderBottomSheetsUtil({
    required this.context,
    required this.language,
    required this.meetingState,
    required this.appointmentType,
    required this.dateFrom,
    required this.dateTo,
    required this.suffixeName,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.profileImg,
    required this.flagImage,
    required this.categoryName,
    required this.dateOfBirth,
    required this.userType,
    required this.noteFromCustomer,
    required this.noteFromAttorney,
    required this.currency,
    required this.price,
    required this.totalPrice,
  });

  Future bookMeetingBottomSheet({
    required Function() cancel,
    required Function() addNote,
  }) async {
    return await showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        enableDrag: true,
        useRootNavigator: true,
        context: context,
        backgroundColor: Colors.white,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context) {
          return Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
            child: Wrap(
              children: [
                Row(
                  children: [
                    CustomText(
                      title: AppLocalizations.of(context)!.meetingwith,
                      textColor: const Color(0xff444444),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    const Expanded(child: SizedBox()),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                meetingView(
                  dateFrom: dateFrom!,
                  dateTo: dateTo!,
                  suffixeName: suffixeName!,
                  firstName: firstName!,
                  lastName: lastName!,
                  gender: gender!,
                  profileImg: profileImg!,
                  flagImage: flagImage!,
                  categoryName: categoryName!,
                  dateOfBirth: dateOfBirth!,
                  userType: userType,
                  appointmentType: appointmentType!,
                  state: meetingState!,
                  price: price!,
                  totalPrice: totalPrice!,
                  currency: currency!,
                  noteFromCustomer: noteFromCustomer!,
                  noteFromAttorney: noteFromAttorney!,
                ),
                const SizedBox(height: 20),
                CustomButton(
                  enableButton: true,
                  padding: const EdgeInsets.all(8.0),
                  buttonColor: const Color(0xff4CB6EA),
                  buttonTitle: AppLocalizations.of(context)!.addeditnote,
                  onTap: () {
                    Navigator.pop(context);
                    addNote();
                  },
                ),
                CustomButton(
                  enableButton:
                      DateTime.now().isBefore(DateTime.parse(dateFrom!)) &&
                          meetingState == 1,
                  padding: const EdgeInsets.all(8.0),
                  buttonColor: const Color(0xffda1100),
                  buttonTitle: AppLocalizations.of(context)!.cancelappointment,
                  onTap: () {
                    Navigator.pop(context);
                    cancel();
                  },
                )
              ],
            ),
          );
        });
  }

  Widget meetingView({
    required String dateFrom,
    required String dateTo,
    required String profileImg,
    required String flagImage,
    required String suffixeName,
    required String firstName,
    required String lastName,
    required String categoryName,
    required String gender,
    required String dateOfBirth,
    required UserType userType,
    required int appointmentType,
    required int state,
    required double price,
    required double totalPrice,
    required String currency,
    required String noteFromCustomer,
    required String noteFromAttorney,
  }) {
    DateTime fromTime = DateTime.parse(dateFrom);
    DateTime toTime = DateTime.parse(dateTo);
    final difference = toTime.difference(fromTime).inMinutes;

    return Column(
      children: [
        OtherUserInfoView(
          profileImg: profileImg,
          flagImage: flagImage,
          suffixName: suffixeName,
          firstName: firstName,
          lastName: lastName,
          categoryName: categoryName,
          gender: gender,
          dateOfBirth: dateOfBirth,
          userType: userType,
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.eventdate,
          desc: "${fromTime.year}/${fromTime.month}/${fromTime.day}",
          padding: const EdgeInsets.all(8),
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.eventday,
          desc: language == "en"
              ? DateFormat('EEEE').format(fromTime)
              : DayTime().convertDayToArabic(
                  DateFormat('EEEE').format(fromTime),
                ),
          padding: const EdgeInsets.all(8),
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.sessiontype,
          desc: _sessionType(appointmentType),
          padding: const EdgeInsets.all(8),
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.meetingtime,
          desc: DayTime().convertingTimingWithMinToRealTime(
              fromTime.hour, fromTime.minute),
          padding: const EdgeInsets.all(8),
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.meetingduration,
          desc: "$difference ${AppLocalizations.of(context)!.min}",
          padding: const EdgeInsets.all(8),
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.meetingstatus,
          desc: _sessionStatusString(_handleMeetingState(state)),
          descColor: _handleMeetingState(state) == AppointmentsState.active
              ? Colors.green
              : Colors.red,
          padding: const EdgeInsets.all(8),
        ),
        PriceView(
          priceBeforeDiscount: price,
          priceAfterDiscount: totalPrice,
          currency: currency,
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.clientnote,
          desc: noteFromCustomer == "" ? "-" : noteFromCustomer,
          padding: const EdgeInsets.all(8),
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.mentornote,
          desc: noteFromAttorney == "" ? "-" : noteFromAttorney,
          padding: const EdgeInsets.all(8),
        ),
        Container(height: 1, color: const Color(0xff444444)),
      ],
    );
  }

  String _sessionType(int id) {
    if (id == 1) {
      return AppLocalizations.of(context)!.schudule;
    } else {
      return AppLocalizations.of(context)!.instant;
    }
  }

  AppointmentsState _handleMeetingState(int index) {
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

  String _sessionStatusString(AppointmentsState state) {
    switch (state) {
      case AppointmentsState.active:
        return AppLocalizations.of(context)!.active;

      case AppointmentsState.customerCancel:
        return AppLocalizations.of(context)!.clientcancelcall;

      case AppointmentsState.attorneyCancel:
        return AppLocalizations.of(context)!.mentorcancelcall;

      case AppointmentsState.customerMiss:
        return AppLocalizations.of(context)!.clientmisscall;

      case AppointmentsState.attorneyMiss:
        return AppLocalizations.of(context)!.mentormisscall;

      case AppointmentsState.completed:
        return AppLocalizations.of(context)!.compleated;
    }
  }
}
