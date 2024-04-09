import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:legalz_hub_app/locator.dart';
import 'package:legalz_hub_app/models/https/appointment_request.dart';
import 'package:legalz_hub_app/models/https/attorney_info_avaliable_model.dart';
import 'package:legalz_hub_app/services/customer/attorney_details_service.dart';
import 'package:legalz_hub_app/services/customer/customer_appointments_service.dart';
import 'package:legalz_hub_app/services/discount_service.dart';
import 'package:legalz_hub_app/services/filter_services.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/currency.dart';
import 'package:legalz_hub_app/utils/day_time.dart';
import 'package:legalz_hub_app/utils/enums/loading_status.dart';
import 'package:legalz_hub_app/utils/error/exceptions.dart';
import 'package:legalz_hub_app/utils/mixins.dart';

enum BookingType {
  schudule,
  instant,
}

enum PaymentTypeMethod { apple, google, paypal, freeCall }

class BookingBloc extends Bloc<DiscountService> {
  TextEditingController noteController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  ValueNotifier<String> discountErrorMessage = ValueNotifier<String>("");
  ValueNotifier<bool> applyDiscountButton = ValueNotifier<bool>(false);

  String? scheduleAttorneyProfileImageUrl;
  String? scheduleAttorneySuffixName;
  String? scheduleAttorneyFirstName;
  String? scheduleAttorneyLastName;
  int? attorneyId;
  double? attorneyHourRate;
  String? attorneyCurrency;
  String? scheduleAttorneyGender;
  String? attorneyCountryName;
  String? attorneyCountryFlag;
  DateTime? attorneyMeetingdate;
  int? attorneyMeetingtime;
  String? meetingDay;
  bool meetingFreeCall = false;

  int? categoryID;
  String? categoryName;
  Timing? meetingduration;
  BookingType? bookingType;
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  bool enablePayButton = false;

  String? countryCode;
  String? currencyCode;

  ValueNotifier<List<AttorneyInfoAvaliableResponseData>?> avaliableAttornies =
      ValueNotifier<List<AttorneyInfoAvaliableResponseData>?>(null);

  ValueNotifier<LoadingStatus> loadingStatus =
      ValueNotifier<LoadingStatus>(LoadingStatus.idle);
  ValueNotifier<String> errorFoundingAttornies = ValueNotifier<String>("");

  void handleReadingArguments(BuildContext context,
      {required Object? arguments}) {
    loadingStatus.value = LoadingStatus.inprogress;
    if (arguments != null) {
      final newArguments = arguments as Map<String, dynamic>;
      bookingType = newArguments["bookingType"] as BookingType;
      categoryID = newArguments["categoryID"] as int?;
      categoryName = newArguments["categoryName"] as String?;
      meetingduration = newArguments["meetingduration"] as Timing?;

      if (bookingType == BookingType.instant) {
        _checkingAvaliableAttornies(categoryID!);
      } else {
        attorneyId = newArguments["attorney_id"] as int?;
        scheduleAttorneyProfileImageUrl =
            newArguments["profileImageUrl"] as String? ?? "";
        scheduleAttorneySuffixName = newArguments["suffixeName"] as String?;
        scheduleAttorneyFirstName = newArguments["firstName"] as String?;
        scheduleAttorneyLastName = newArguments["lastName"] as String?;
        attorneyHourRate = newArguments["hourRate"] as double?;
        attorneyCurrency = newArguments["currency"] as String?;
        countryCode = newArguments["countryCode"] as String?;
        currencyCode = newArguments["currencyCode"] as String?;
        scheduleAttorneyGender = newArguments["gender"] as String?;
        attorneyCountryName = newArguments["countryName"] as String?;
        attorneyCountryFlag = newArguments["countryFlag"] as String?;
        attorneyMeetingdate = newArguments["meetingDate"] as DateTime?;
        attorneyMeetingtime = newArguments["meetingTime"] as int?;
        meetingFreeCall = newArguments["freeCall"] as bool;
        meetingDay = meetingDayNamed(attorneyMeetingdate);
        enablePayButton = true;
        loadingStatus.value = LoadingStatus.finish;
      }
    }
  }

  String? meetingDayNamed(DateTime? date) {
    if (date != null) {
      var dayName = DateFormat('EEEE').format(date);
      return box.get(DatabaseFieldConstant.language) == "en"
          ? dayName
          : DayTime().convertDayToArabic(dayName);
    }
    return null;
  }

  String? meetingDate(DateTime? date) {
    if (date != null) {
      final format = DateFormat('yyyy/MM/dd');
      return format.format(date);
    }
    return null;
  }

  String? meetingTime(int? time) {
    if (time != null) {
      return DayTime().convertingTimingWithMinToRealTime(time, 0);
    }
    return null;
  }

  double calculateMeetingCostAmountVariable = 0.0;
  double? calculateMeetingCost(
      {required double? hourRate,
      required Timing? duration,
      required bool freeCall}) {
    if (hourRate == null || duration == null) {
      calculateMeetingCostAmountVariable = 0.0;
      return calculateMeetingCostAmountVariable;
    } else {
      switch (duration) {
        case Timing.quarterHour:
          if (freeCall) {
            calculateMeetingCostAmountVariable = 0.0;
            return calculateMeetingCostAmountVariable;
          } else {
            calculateMeetingCostAmountVariable = (hourRate / 4);
            return calculateMeetingCostAmountVariable;
          }

        case Timing.halfHour:
          calculateMeetingCostAmountVariable = (hourRate / 2);
          return calculateMeetingCostAmountVariable;
        case Timing.threeQuarter:
          calculateMeetingCostAmountVariable = (hourRate - (hourRate / 4));
          return calculateMeetingCostAmountVariable;
        case Timing.hour:
          calculateMeetingCostAmountVariable = hourRate;
          return calculateMeetingCostAmountVariable;
      }
    }
  }

  double calculateTotalAmountVariable = 0.0;
  double calculateTotalAmount(
      {required double? hourRate,
      required Timing? duration,
      required String discount,
      required bool freeCall}) {
    if (hourRate == null || duration == null) {
      calculateTotalAmountVariable = 0.0;
      return calculateTotalAmountVariable;
    } else {
      double newDiscount = 0;

      if (discount != "" && discount != "error") {
        newDiscount = double.parse(discount);
      }

      switch (duration) {
        case Timing.quarterHour:
          if (freeCall) {
            calculateTotalAmountVariable = 0;
            return calculateTotalAmountVariable;
          } else {
            if (newDiscount > 0) {
              calculateTotalAmountVariable =
                  (hourRate / 4) - ((hourRate / 4) * (newDiscount / 100));
              return calculateTotalAmountVariable;
            } else {
              calculateTotalAmountVariable = (hourRate / 4);
              return calculateTotalAmountVariable;
            }
          }
        case Timing.halfHour:
          if (newDiscount > 0) {
            calculateTotalAmountVariable =
                (hourRate / 2) - ((hourRate / 2) * (newDiscount / 100));
            return calculateTotalAmountVariable;
          } else {
            calculateTotalAmountVariable = (hourRate / 2);
            return calculateTotalAmountVariable;
          }

        case Timing.threeQuarter:
          if (newDiscount > 0) {
            calculateTotalAmountVariable = (hourRate - (hourRate / 4)) -
                ((hourRate - (hourRate / 4)) * (newDiscount / 100));
            return calculateTotalAmountVariable;
          } else {
            calculateTotalAmountVariable = (hourRate - (hourRate / 4));
            return calculateTotalAmountVariable;
          }

        case Timing.hour:
          if (newDiscount > 0) {
            calculateTotalAmountVariable =
                hourRate - (hourRate * (newDiscount / 100));
            return calculateTotalAmountVariable;
          } else {
            calculateTotalAmountVariable = hourRate;
            return calculateTotalAmountVariable;
          }
      }
    }
  }

  _checkingAvaliableAttornies(int catID) async {
    try {
      var attornies = await locator<AttorneyDetailsService>()
          .getAttorneyAvaliable(categoryID: catID);
      if (attornies.data != null) {
        avaliableAttornies.value = attornies.data;
        attorneyId = attornies.data![0].id;
        attorneyHourRate = attornies.data![0].hourRate;
        attorneyCurrency = attornies.data![0].currency;
        countryCode = attornies.data![0].countryCode;
        currencyCode = attornies.data![0].currencyCode;
        attorneyMeetingdate =
            DateFormat("yyyy-MM-dd").parse(attornies.data![0].date!);
        meetingDay = meetingDayNamed(attorneyMeetingdate);
        attorneyMeetingtime = attornies.data![0].hour!;
        meetingFreeCall = false;
        enablePayButton = true;
        errorFoundingAttornies.value = "";
        loadingStatus.value = LoadingStatus.finish;
      }
    } on DioException catch (e) {
      final error = e.error as HttpException;
      errorFoundingAttornies.value = error.message.toString();
      loadingStatus.value = LoadingStatus.finish;
    }
  }

  DateTime _calculateDateFromToUTC({required BookingType bookingType}) {
    switch (bookingType) {
      case BookingType.instant:
        return DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                DateTime.now().hour + attorneyMeetingtime! + 1,
                0)
            .toUtc();
      case BookingType.schudule:
        return DateTime(attorneyMeetingdate!.year, attorneyMeetingdate!.month,
                attorneyMeetingdate!.day, attorneyMeetingtime!)
            .toUtc();
    }
  }

  DateTime _calculateDateToToUTC(
      {required DateTime dateFrom, required Timing duration}) {
    switch (duration) {
      case Timing.quarterHour:
        return dateFrom.add(const Duration(minutes: 15));
      case Timing.halfHour:
        return dateFrom.add(const Duration(minutes: 30));
      case Timing.threeQuarter:
        return dateFrom.add(const Duration(minutes: 45));
      case Timing.hour:
        return dateFrom.add(const Duration(minutes: 60));
    }
  }

  Future<dynamic> bookMeetingRequest(PaymentTypeMethod payment) async {
    DateTime fromDateTime = _calculateDateFromToUTC(bookingType: bookingType!);
    DateTime toDateTime = _calculateDateToToUTC(
        dateFrom: fromDateTime, duration: meetingduration!);

    int paymentMethod = 0;
    switch (payment) {
      case PaymentTypeMethod.apple:
        paymentMethod = 1;
        break;
      case PaymentTypeMethod.google:
        paymentMethod = 2;
        break;
      case PaymentTypeMethod.paypal:
        paymentMethod = 3;
        break;
      case PaymentTypeMethod.freeCall:
        paymentMethod = 4;
        break;
    }

    final appointment = AppointmentRequest(
      attorneyId: attorneyId!,
      isFree: meetingFreeCall,
      type: bookingType == BookingType.schudule ? 1 : 2,
      attorneyHourRate: attorneyHourRate!,
      discountId: selectedDiscountId,
      payment: paymentMethod,
      price: calculateMeetingCostAmountVariable,
      totalPrice: calculateTotalAmountVariable,
      countryId: int.parse(box.get(DatabaseFieldConstant.selectedCountryId)),
      dateFrom: CustomDate(
          year: fromDateTime.year,
          month: fromDateTime.month,
          day: fromDateTime.day,
          hour: fromDateTime.hour,
          min: fromDateTime.minute),
      dateTo: CustomDate(
          year: toDateTime.year,
          month: toDateTime.month,
          day: toDateTime.day,
          hour: toDateTime.hour,
          min: toDateTime.minute),
      note: noteController.text.isEmpty ? null : noteController.text,
    );

    return await locator<CustomerAppointmentsService>()
        .bookNewAppointments(appointment: appointment);
  }

  handleLisinnerOfDiscountController() {
    discountController.addListener(() {
      applyDiscountButton.value = false;
      discountErrorMessage.value = "";
      if (discountController.text.length == 6) {
        applyDiscountButton.value = true;
      }
    });
  }

  int? selectedDiscountId;
  void verifyCode() {
    service.discount(discountController.text).then((value) {
      if (value.data == null) {
        selectedDiscountId = null;
        discountErrorMessage.value = "error";
      } else {
        selectedDiscountId = value.data!.id;
        discountErrorMessage.value = value.data!.percentValue!.toString();
      }
    });
  }

  double calculateDiscountPercent(String snapshot) {
    if (snapshot == "") {
      return 0.0;
    } else if (snapshot == "error") {
      return 0.0;
    } else {
      return double.tryParse(snapshot) ?? 0.0;
    }
  }

  String meetingDurationParser(Timing duration) {
    switch (duration) {
      case Timing.quarterHour:
        return "15";
      case Timing.halfHour:
        return "30";
      case Timing.threeQuarter:
        return "45";
      case Timing.hour:
        return "60";
    }
  }

  Future<double> currencyConversion(String currency) async {
    return locator<FilterService>().currencyConverter(currency);
  }

  @override
  onDispose() {
    applyDiscountButton.dispose();
  }
}
