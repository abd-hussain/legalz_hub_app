import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/models/https/payment_report_request.dart';
import 'package:legalz_hub_app/models/https/payments_response.dart';
import 'package:legalz_hub_app/services/attorney/attorney_payment_services.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/mixins.dart';

class PaymentsBloc extends Bloc<PaymentService> {
  final ValueNotifier<List<PaymentResponseData>> paymentListNotifier =
      ValueNotifier<List<PaymentResponseData>>([]);
  double pendingTotalAmount = 0;
  double recivedTotalAmount = 0;
  String currency = "";
  var box = Hive.box(DatabaseBoxConstant.userInfo);

  getListOfPayments() {
    service.listOfPayments().then((value) {
      if (value.data != null) {
        pendingTotalAmount = 0;
        recivedTotalAmount = 0;
        for (PaymentResponseData item in value.data!) {
          if (item.appointmentIsFree == false) {
            if (item.paymentStatus == 1) {
              if (item.appointmentDiscountId != null) {
                pendingTotalAmount =
                    pendingTotalAmount + item.appointmentTotalPrice!;
              } else {
                pendingTotalAmount =
                    pendingTotalAmount + item.appointmentPrice!;
              }
            } else {
              if (item.appointmentDiscountId != null) {
                recivedTotalAmount =
                    recivedTotalAmount + item.appointmentTotalPrice!;
              } else {
                recivedTotalAmount =
                    recivedTotalAmount + item.appointmentPrice!;
              }
            }
          }

          currency = item.currency ?? "";
        }

        paymentListNotifier.value = value.data!;
      }
    });
  }

  Future<dynamic> reportPayment(int id, String message) async {
    PaymentReportRequest data =
        PaymentReportRequest(message: message, paymentId: id);
    return service.reportPayment(data);
  }

  @override
  onDispose() {}
}
