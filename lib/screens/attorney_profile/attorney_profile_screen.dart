import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ionicons/ionicons.dart';
import 'package:legalz_hub_app/screens/attorney_profile/attorney_profile_bloc.dart';
import 'package:legalz_hub_app/screens/attorney_profile/widgets/footer_view.dart';
import 'package:legalz_hub_app/screens/attorney_profile/widgets/grid_item.dart';
import 'package:legalz_hub_app/screens/attorney_profile/widgets/review_header_view.dart';
import 'package:legalz_hub_app/screens/attorney_profile/widgets/reviews_body_view.dart';
import 'package:legalz_hub_app/screens/booking_meeting/booking_bloc.dart';
import 'package:legalz_hub_app/shared_widget/custom_appbar.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/utils/constants/constant.dart';
import 'package:legalz_hub_app/utils/enums/loading_status.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/routes.dart';

class AttorneyProfileScreen extends StatefulWidget {
  const AttorneyProfileScreen({super.key});

  @override
  State<AttorneyProfileScreen> createState() => _AttorneyProfileScreenState();
}

class _AttorneyProfileScreenState extends State<AttorneyProfileScreen> {
  final bloc = AttorneyProfileBloc();

  @override
  void didChangeDependencies() {
    bloc.handleReadingArguments(context,
        arguments: ModalRoute.of(context)!.settings.arguments);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      appBar: customAppBar(
        title: AppLocalizations.of(context)!.mentorprofile,
        userType: UserType.customer,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ValueListenableBuilder<LoadingStatus>(
              valueListenable: bloc.loadingStatus,
              builder: (context, loadingsnapshot, child) {
                if (loadingsnapshot != LoadingStatus.inprogress) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 120,
                              height: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: bloc.profileImageUrl != ""
                                    ? Image.network(
                                        AppConstant.imagesBaseURLForAttorney +
                                            bloc.profileImageUrl!,
                                        fit: BoxFit.fill,
                                      )
                                    : Image.asset(
                                        'assets/images/avatar.jpeg',
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  title: bloc.suffixeName!,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  textColor: const Color(0xff554d56),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 160,
                                  child: CustomText(
                                    title:
                                        "${bloc.firstName!} ${bloc.lastName!}",
                                    fontSize: 18,
                                    maxLins: 3,
                                    fontWeight: FontWeight.bold,
                                    textColor: const Color(0xff554d56),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      title:
                                          "${AppLocalizations.of(context)!.category} :",
                                      fontSize: 12,
                                      textColor: const Color(0xff554d56),
                                    ),
                                    const SizedBox(width: 8),
                                    CustomText(
                                      title: bloc.categoryName!,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      textColor: const Color(0xff554d56),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        CustomText(
                          title: bloc.bio!,
                          fontSize: 12,
                          maxLins: 5,
                          textColor: const Color(0xff554d56),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MentorGridItem(
                                  title: AppLocalizations.of(context)!.language,
                                  value: bloc.speakingLanguage!,
                                  icon: const Icon(
                                    Icons.translate,
                                    color: Color(0xff444444),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                MentorGridItem(
                                  title: AppLocalizations.of(context)!.gender,
                                  value: bloc.gender!,
                                  icon: Icon(
                                    bloc.genderIndex == 1
                                        ? Icons.male
                                        : Icons.female,
                                    color: const Color(0xff444444),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                MentorGridItem(
                                  title: AppLocalizations.of(context)!.hourrate,
                                  value: "${bloc.hourRate} ${bloc.currency}",
                                  icon: const Icon(
                                    Ionicons.wallet_outline,
                                    color: Color(0xff444444),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MentorGridItem(
                                  title: AppLocalizations.of(context)!
                                      .countryprofile,
                                  value: bloc.countryName!,
                                  icon: SizedBox(
                                    width: 30,
                                    child: FadeInImage(
                                      placeholder: const AssetImage(
                                          "assets/images/flagPlaceHolderImg.png"),
                                      image: NetworkImage(AppConstant
                                              .imagesBaseURLForCountries +
                                          bloc.countryFlag!),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                MentorGridItem(
                                  title:
                                      AppLocalizations.of(context)!.experience,
                                  value:
                                      "${bloc.calculateExperience(bloc.experienceSince)} ${AppLocalizations.of(context)!.year}",
                                  icon: const Icon(
                                    Ionicons.library_outline,
                                    color: Color(0xff444444),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                MentorGridItem(
                                  title: AppLocalizations.of(context)!
                                      .freecallexsist,
                                  value: bloc.freeCall
                                      ? AppLocalizations.of(context)!.avaliable
                                      : AppLocalizations.of(context)!
                                          .notavaliable,
                                  icon: const Icon(
                                    Ionicons.magnet_outline,
                                    color: Color(0xff444444),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        CustomText(
                          title:
                              "-- ${AppLocalizations.of(context)!.ratingandreview} --",
                          fontSize: 14,
                          textColor: const Color(0xff554d56),
                        ),
                        ReviewHeaderView(
                          ratesCount: bloc.reviews.length,
                          totalRates: bloc.totalRate,
                        ),
                        SizedBox(
                          height: bloc.reviews.isEmpty ? 20 : 400,
                          child: ReviewBodyView(reviews: bloc.reviews),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    ),
                  );
                }
              }),
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder<LoadingStatus>(
          valueListenable: bloc.loadingStatus,
          builder: (context, loadingsnapshot, child) {
            if (loadingsnapshot != LoadingStatus.inprogress) {
              return AttorneyProfileFooterView(
                hourRate: bloc.hourRate!,
                currency: bloc.currency!,
                freeCall: bloc.freeCall,
                workingHoursFriday: bloc.workingHoursFriday,
                workingHoursWednesday: bloc.workingHoursWednesday,
                workingHoursMonday: bloc.workingHoursMonday,
                workingHoursSaturday: bloc.workingHoursSaturday,
                workingHoursSunday: bloc.workingHoursSunday,
                workingHoursThursday: bloc.workingHoursThursday,
                workingHoursTuesday: bloc.workingHoursTuesday,
                listOfAppointments: bloc.listOfAppointments,
                openBookingView: (selectedMeetingDuration, selectedMeetingDate,
                    selectedMeetingTime) {
                  Navigator.of(context, rootNavigator: true).pushNamed(
                    RoutesConstants.bookingScreen,
                    arguments: {
                      "bookingType": BookingType.schudule,
                      "attorney_id": bloc.attorneyId!,
                      "profileImageUrl": bloc.profileImageUrl!,
                      "suffixeName": bloc.suffixeName!,
                      "firstName": bloc.firstName!,
                      "lastName": bloc.lastName!,
                      "hourRate": bloc.hourRate!,
                      "currency": bloc.currency!,
                      "countryCode": bloc.countryCode!,
                      "currencyCode": bloc.currencyCode!,
                      "gender": bloc.gender!,
                      "freeCall": bloc.freeCall,
                      "categoryID": bloc.categoryID!,
                      "categoryName": bloc.categoryName!,
                      "meetingduration": selectedMeetingDuration,
                      "countryName": bloc.countryName!,
                      "countryFlag": bloc.countryFlag!,
                      "meetingDate": selectedMeetingDate,
                      "meetingTime": selectedMeetingTime
                    },
                  );
                },
              );
            } else {
              return const SizedBox(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                ),
              );
            }
          }),
    );
  }
}
