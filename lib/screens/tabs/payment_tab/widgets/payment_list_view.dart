import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:legalz_hub_app/models/https/payments_response.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/screens/tabs/payment_tab/widgets/client_view.dart';
import 'package:legalz_hub_app/shared_widget/appointment_details_view.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class PaymentListView extends StatelessWidget {
  final List<PaymentResponseData> list;
  final Function(PaymentResponseData) onReportPressed;
  const PaymentListView(
      {required this.list, super.key, required this.onReportPressed});

  @override
  Widget build(BuildContext context) {
    return list.isNotEmpty
        ? Padding(
            padding:
                const EdgeInsets.only(top: 0, right: 8, left: 8, bottom: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xff444444)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                padding: const EdgeInsets.all(8),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return _buildExpandableTile(context, list[index], (item) {
                    onReportPressed(item);
                  });
                },
              ),
            ),
          )
        : Center(
            child: CustomText(
              title: AppLocalizations.of(context)!.nodatatoshow,
              fontSize: 14,
              textColor: const Color(0xff444444),
            ),
          );
  }

  Widget _buildExpandableTile(BuildContext context, PaymentResponseData item,
      Function(PaymentResponseData) onReportPressed) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final DateTime parsedDate = DateTime.parse(item.createdAt!);

    DateTime dateFrom = DateTime.parse(item.appointmentDateFrom!);
    DateTime dateTo = DateTime.parse(item.appointmentDateTo!);

    Duration difference = dateTo.difference(dateFrom);
    int totalMinutes = difference.inMinutes;

    return ExpansionTile(
      title: Row(
        children: [
          Icon(
            Ionicons.receipt_outline,
            color: item.paymentStatus! == 1
                ? Colors.orange
                : item.paymentStatus! == 2
                    ? Colors.green
                    : Colors.red,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: "ID : ${item.id!}",
                fontSize: 12,
                textColor: const Color(0xff444444),
              ),
              CustomText(
                title: formatter.format(parsedDate),
                fontSize: 12,
                textColor: const Color(0xff444444),
              ),
            ],
          ),
          Expanded(child: Container()),
          CustomText(
            title: item.appointmentIsFree!
                ? AppLocalizations.of(context)!.free
                : "${item.appointmentDiscountId != null ? item.appointmentTotalPrice! : item.appointmentPrice!} ${item.currency}",
            fontSize: 16,
            fontWeight: FontWeight.bold,
            textColor: const Color(0xff444444),
          ),
        ],
      ),
      children: <Widget>[
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.clientnote,
          desc: item.noteFromCustomer ?? "-",
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.mentornote,
          desc: item.noteFromAttorney ?? "-",
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.fromdate,
          desc: item.appointmentDateFrom ?? "",
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.todate,
          desc: item.appointmentDateTo ?? "",
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.meetingduration,
          desc: "$totalMinutes ${AppLocalizations.of(context)!.min}",
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.mentorrateperhour,
          desc: "${item.attorneyHourRate ?? 0.0} ${item.currency}",
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.pricebefore,
          desc: "${item.appointmentPrice ?? 0.0} ${item.currency}",
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.priceafter,
          desc: "${item.appointmentTotalPrice ?? 0.0} ${item.currency}",
        ),
        ClientView(
          clientProfileImg: item.customerProfileImg ?? "",
          clientFirstName: item.customerFirstName ?? "",
          clientLastName: item.customerLastName ?? "",
          clientCountryFlag: item.customerFlagImg ?? "",
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: item.paymentReportedMessage != null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          CustomText(
                            title:
                                "${AppLocalizations.of(context)!.alreadyreportpayment} ${AppLocalizations.of(context)!.witha}",
                            fontSize: 10,
                            textAlign: TextAlign.center,
                            maxLins: 2,
                            fontWeight: FontWeight.bold,
                            textColor: const Color(0xff444444),
                          ),
                          const SizedBox(height: 5),
                          CustomText(
                            title: item.paymentReportedMessage!,
                            fontSize: 10,
                            textAlign: TextAlign.center,
                            maxLins: 2,
                            fontWeight: FontWeight.bold,
                            textColor: const Color(0xff444444),
                          ),
                        ],
                      ),
                    ),
                  )
                : TextButton(
                    onPressed: () => onReportPressed(item),
                    child: CustomText(
                      title: AppLocalizations.of(context)!.reportproblem,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      textColor: Colors.red,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
