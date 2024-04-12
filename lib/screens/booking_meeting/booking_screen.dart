import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:legalz_hub_app/locator.dart';
import 'package:legalz_hub_app/screens/booking_meeting/booking_bloc.dart';
import 'package:legalz_hub_app/screens/booking_meeting/widgets/bill_details_view.dart';
import 'package:legalz_hub_app/screens/booking_meeting/widgets/discount_view.dart';
import 'package:legalz_hub_app/screens/booking_meeting/widgets/instance_booking_view.dart';
import 'package:legalz_hub_app/screens/booking_meeting/widgets/item_in_gred.dart';
import 'package:legalz_hub_app/screens/booking_meeting/widgets/meeting_timing_view.dart';
import 'package:legalz_hub_app/screens/booking_meeting/widgets/no_mentor_found_view.dart';
import 'package:legalz_hub_app/screens/booking_meeting/widgets/note_view.dart';
import 'package:legalz_hub_app/screens/booking_meeting/widgets/schedule_booking_view.dart';
import 'package:legalz_hub_app/screens/main_container/main_container_bloc.dart';
import 'package:legalz_hub_app/shared_widget/booking/payment_bottom_sheet.dart';
import 'package:legalz_hub_app/shared_widget/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/custom_button.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/loading_status.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/error/exceptions.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final bloc = BookingBloc();

  @override
  void didChangeDependencies() {
    bloc.handleReadingArguments(context,
        arguments: ModalRoute.of(context)!.settings.arguments);
    bloc.handleLisinnerOfDiscountController();
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
          title: AppLocalizations.of(context)!.booknow,
          userType: UserType.customer),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ValueListenableBuilder<LoadingStatus>(
            valueListenable: bloc.loadingStatus,
            builder: (context, loadingsnapshot, child) {
              if (loadingsnapshot != LoadingStatus.inprogress) {
                return SafeArea(
                  child: SingleChildScrollView(
                    child: ValueListenableBuilder<String>(
                      valueListenable: bloc.errorFoundingAttornies,
                      builder: (context, errorFoundingMentorsSnapshot, child) {
                        return errorFoundingMentorsSnapshot == ""
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  bloc.bookingType == BookingType.schudule
                                      ? ScheduleBookingView(
                                          profileImg: bloc
                                              .scheduleAttorneyProfileImageUrl,
                                          flagImage: bloc.attorneyCountryFlag,
                                          gender: bloc.scheduleAttorneyGender,
                                          firstName:
                                              bloc.scheduleAttorneyFirstName,
                                          lastName:
                                              bloc.scheduleAttorneyLastName,
                                          suffixName:
                                              bloc.scheduleAttorneySuffixName,
                                          categoryName: bloc.categoryName,
                                        )
                                      : InstanceBookingView(
                                          avaliableAttornies:
                                              bloc.avaliableAttornies,
                                          categoryName: bloc.categoryName,
                                          onSelectAttorney: (attorneyDate) {
                                            bloc.loadingStatus.value =
                                                LoadingStatus.inprogress;
                                            bloc.attorneyId = attorneyDate.id;
                                            bloc.attorneyHourRate =
                                                attorneyDate.hourRate;
                                            bloc.attorneyCurrency =
                                                attorneyDate.currency;
                                            bloc.attorneyMeetingdate =
                                                DateFormat("yyyy-MM-dd")
                                                    .parse(attorneyDate.date!);
                                            bloc.meetingDay =
                                                bloc.meetingDayNamed(
                                                    bloc.attorneyMeetingdate);
                                            bloc.attorneyMeetingtime =
                                                attorneyDate.hour!;
                                            bloc.meetingFreeCall = false;
                                            bloc.enablePayButton = true;
                                            bloc.loadingStatus.value =
                                                LoadingStatus.finish;
                                          },
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, left: 16, bottom: 8),
                                    child: CustomText(
                                      title: AppLocalizations.of(context)!
                                          .appointmentdetails,
                                      fontSize: 12,
                                      textColor: const Color(0xff554d56),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16),
                                    child: ItemInGrid(
                                      title: AppLocalizations.of(context)!
                                          .meetingdate,
                                      value: bloc.meetingDate(
                                          bloc.attorneyMeetingdate),
                                    ),
                                  ),
                                  MeetingTimingView(
                                    date: bloc.meetingDay,
                                    time: bloc.bookingType ==
                                            BookingType.schudule
                                        ? bloc.meetingTime(
                                            bloc.attorneyMeetingtime)
                                        : "${AppLocalizations.of(context)!.within} ${bloc.attorneyMeetingtime! + 1} ${AppLocalizations.of(context)!.hour}",
                                    duration: bloc.meetingduration != null
                                        ? bloc.meetingDurationParser(
                                            bloc.meetingduration!)
                                        : null,
                                    type: bloc.bookingType,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, left: 16),
                                    child: Container(
                                        height: 0.5,
                                        color: const Color(0xff444444)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16,
                                        right: 16,
                                        left: 16,
                                        bottom: 8),
                                    child: CustomText(
                                      title: AppLocalizations.of(context)!
                                          .writenoteformentor,
                                      fontSize: 12,
                                      textColor: const Color(0xff554d56),
                                    ),
                                  ),
                                  NoteView(controller: bloc.noteController),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, bottom: 8),
                                    child: CustomText(
                                      title: AppLocalizations.of(context)!
                                          .writenoteformentorsmallMessage,
                                      fontSize: 12,
                                      textColor: const Color(0xff554d56),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, left: 16),
                                    child: Container(
                                        height: 0.5,
                                        color: const Color(0xff444444)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16,
                                        right: 16,
                                        left: 16,
                                        bottom: 8),
                                    child: CustomText(
                                      title: AppLocalizations.of(context)!
                                          .billdetails,
                                      fontSize: 12,
                                      textColor: const Color(0xff554d56),
                                    ),
                                  ),
                                  ValueListenableBuilder<String>(
                                      valueListenable:
                                          bloc.discountErrorMessage,
                                      builder: (context, discountErrorsnapshot,
                                          child) {
                                        return BillDetailsView(
                                          currency: bloc.attorneyCurrency,
                                          meetingCostAmount:
                                              bloc.calculateMeetingCost(
                                                  hourRate:
                                                      bloc.attorneyHourRate,
                                                  duration:
                                                      bloc.meetingduration,
                                                  freeCall:
                                                      bloc.meetingFreeCall),
                                          totalAmount:
                                              bloc.calculateTotalAmount(
                                                  hourRate:
                                                      bloc.attorneyHourRate,
                                                  duration:
                                                      bloc.meetingduration,
                                                  discount:
                                                      discountErrorsnapshot,
                                                  freeCall:
                                                      bloc.meetingFreeCall),
                                          discountPercent:
                                              bloc.calculateDiscountPercent(
                                                  discountErrorsnapshot),
                                        );
                                      }),
                                  const SizedBox(height: 8),
                                  DiscountView(
                                    controller: bloc.discountController,
                                    discountErrorMessage:
                                        bloc.discountErrorMessage,
                                    applyDiscountButton:
                                        bloc.applyDiscountButton,
                                    applyDiscountButtonCallBack: () {
                                      bloc.verifyCode();
                                      bloc.applyDiscountButton.value = false;
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, left: 16, top: 8),
                                    child: Container(
                                        height: 0.5,
                                        color: const Color(0xff444444)),
                                  ),
                                  CustomButton(
                                    enableButton: bloc.enablePayButton,
                                    buttonTitle:
                                        AppLocalizations.of(context)!.pay,
                                    onTap: () async {
                                      if (bloc.calculateTotalAmountVariable >
                                          0) {
                                        final bottomSheet =
                                            PaymentBottomSheetsUtil();

                                        if (bloc.currencyCode !=
                                            bloc.box.get(DatabaseFieldConstant
                                                .selectedCurrencyCode)) {
                                          double dollerEquavilant =
                                              await bloc.currencyConversion(
                                                  bloc.currencyCode!);
                                          if (context.mounted) {
                                            await bottomSheet
                                                .moneyConversionBottomSheet(
                                              context: context,
                                              mentorCurrency:
                                                  bloc.currencyCode!,
                                              dollerEquvilant: dollerEquavilant,
                                              totalAmount: bloc
                                                  .calculateTotalAmountVariable,
                                              onSelectionDone:
                                                  (newValue) async {
                                                await callPaymentBottomSheet(
                                                    totalAmount: newValue,
                                                    currency: "USD",
                                                    countryCode: "US");
                                              },
                                            );
                                          }
                                        } else {
                                          await callPaymentBottomSheet(
                                            totalAmount: bloc
                                                .calculateTotalAmountVariable,
                                            currency: bloc.box.get(
                                                DatabaseFieldConstant
                                                    .selectedCurrencyCode),
                                            countryCode: bloc.box.get(
                                                DatabaseFieldConstant
                                                    .selectedCountryCode),
                                          );
                                        }
                                      } else {
                                        await callRequest(
                                            PaymentTypeMethod.freeCall);
                                      }
                                    },
                                  ),
                                ],
                              )
                            : const NoMentorFoundView();
                      },
                    ),
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
    );
  }

  Future<dynamic> callPaymentBottomSheet(
      {required double totalAmount,
      required String currency,
      required String countryCode}) async {
    final bottomSheet = PaymentBottomSheetsUtil();

    await bottomSheet.paymentBottomSheet(
      context: context,
      totalAmount: totalAmount,
      countryCode: countryCode,
      currency: currency,
      onSelectionDone: (paymentType) async {
        switch (paymentType) {
          case PaymentType.apple:
            await callRequest(PaymentTypeMethod.apple);
            break;
          case PaymentType.google:
            await callRequest(PaymentTypeMethod.google);
            break;
        }
      },
    );
  }

  Future<void> callRequest(PaymentTypeMethod type) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      await bloc.bookMeetingRequest(type);
      _backAfterRequest();
    } on DioException catch (e) {
      final error = e.error as HttpException;
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text(error.message.toString())),
      );
    }
  }

  _backAfterRequest() {
    if (bloc.bookingType == BookingType.schudule) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      locator<MainContainerBloc>().appBarKey.currentState!.animateTo(3);
      locator<MainContainerBloc>().customerCurrentTabIndexNotifier.value =
          CustomerSelectedTab.calender;
    } else {
      Navigator.of(context).pop();
    }
  }
}
