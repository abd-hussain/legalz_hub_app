import 'package:flutter/material.dart';
import 'package:legalz_hub_app/locator.dart';
import 'package:legalz_hub_app/models/https/categories_model.dart';
import 'package:legalz_hub_app/screens/booking_meeting/booking_bloc.dart';
import 'package:legalz_hub_app/screens/main_container/main_container_bloc.dart';
import 'package:legalz_hub_app/shared_widget/booking/instant_booking_bottom_sheet.dart';
import 'package:legalz_hub_app/shared_widget/booking/widgets/points_in_last_view.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/routes.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoCallView extends StatelessWidget {
  final String language;
  final UserType userType;
  final List<Category> listOfCategories;
  final Function() refreshThePage;

  const NoCallView(
      {required this.language,
      required this.userType,
      super.key,
      required this.listOfCategories,
      required this.refreshThePage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset('assets/lottie/86231-confused.zip', height: 200),
        Padding(
          padding: const EdgeInsets.all(8),
          child: CustomText(
            title: AppLocalizations.of(context)!.nocalltoday,
            fontSize: 20,
            textColor: const Color(0xff554d56),
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: CustomText(
            title: AppLocalizations.of(context)!.checkcallfromcalender,
            fontSize: 14,
            textColor: const Color(0xff554d56),
            fontWeight: FontWeight.bold,
          ),
        ),
        userType == UserType.attorney
            ? hintToEncreaseMeetings(context)
            : bookMeeting(context),
      ],
    );
  }

  Widget hintToEncreaseMeetings(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xffE8E8E8),
            ),
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 8),
              CustomText(
                title: AppLocalizations.of(context)!.encreasemeetingshint,
                fontSize: 12,
                maxLins: 2,
                textAlign: TextAlign.center,
                textColor: const Color(0xff554d56),
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                title: AppLocalizations.of(context)!.encreasemeetingshintdesc,
                fontSize: 12,
                textColor: const Color(0xff554d56),
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              PointsInLastViewBooking(
                number: "1",
                text: AppLocalizations.of(context)!.encreasemeetingstep1,
              ),
              const SizedBox(height: 8),
              PointsInLastViewBooking(
                number: "2",
                text: AppLocalizations.of(context)!.encreasemeetingstep2,
              ),
              const SizedBox(height: 8),
              PointsInLastViewBooking(
                number: "3",
                text: AppLocalizations.of(context)!.encreasemeetingstep3,
              ),
              const SizedBox(height: 8),
              PointsInLastViewBooking(
                number: "4",
                text: AppLocalizations.of(context)!.encreasemeetingstep4,
              ),
              const SizedBox(height: 8),
              PointsInLastViewBooking(
                number: "5",
                text: AppLocalizations.of(context)!.encreasemeetingstep5,
              ),
              const SizedBox(height: 8),
              PointsInLastViewBooking(
                number: "6",
                text: AppLocalizations.of(context)!.encreasemeetingstep6,
              ),
              const SizedBox(height: 8),
              PointsInLastViewBooking(
                number: "7",
                text: AppLocalizations.of(context)!.encreasemeetingstep7,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget bookMeeting(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xffE8E8E8),
            ),
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              rowItem(
                context: context,
                containerColor: const Color(0xffE74C4C),
                title: AppLocalizations.of(context)!.meetingnow,
                desc: AppLocalizations.of(context)!.meetingnowdesc,
                icon: Icons.timer,
                onPress: () async {
                  await InstantBookingBottomSheetsUtil().bookMeetingBottomSheet(
                    context: context,
                    listOfCategories: listOfCategories,
                    onEndSelection: (category, time) {
                      Navigator.of(context, rootNavigator: true).pushNamed(
                        RoutesConstants.bookingScreen,
                        arguments: {
                          "bookingType": BookingType.instant,
                          "categoryID": category.id,
                          "categoryName": category.name,
                          "meetingduration": time,
                        },
                      ).then((value) {
                        refreshThePage();
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 8),
              Container(height: 1, color: const Color(0xffE8E8E8)),
              const SizedBox(height: 8),
              rowItem(
                context: context,
                containerColor: const Color(0xff81D8D0),
                title: AppLocalizations.of(context)!.meetingshudule,
                desc: AppLocalizations.of(context)!.meetingshuduledesc,
                icon: Icons.calendar_month_outlined,
                onPress: () {
                  locator<MainContainerBloc>()
                      .appBarKey
                      .currentState!
                      .animateTo(1);
                  locator<MainContainerBloc>()
                      .customerCurrentTabIndexNotifier
                      .value = CustomerSelectedTab.categories;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rowItem(
      {required BuildContext context,
      required Color containerColor,
      required IconData icon,
      required String title,
      required String desc,
      required Function onPress}) {
    return InkWell(
      onTap: () => onPress(),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: containerColor,
            ),
            child: Center(
              child: Icon(icon, color: Colors.white),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: title,
                fontSize: 16,
                textColor: const Color(0xff554d56),
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                title: desc,
                fontSize: 12,
                textColor: const Color(0xffA2A3A4),
                fontWeight: FontWeight.bold,
              )
            ],
          ),
          const Expanded(child: SizedBox()),
          language == "en"
              ? const Icon(Icons.arrow_left_outlined)
              : const Icon(Icons.arrow_right_outlined)
        ],
      ),
    );
  }
}
