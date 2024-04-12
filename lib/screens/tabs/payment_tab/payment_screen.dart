import 'package:flutter/material.dart';
import 'package:legalz_hub_app/models/https/payments_response.dart';
import 'package:legalz_hub_app/screens/tabs/payment_tab/payments_bloc.dart';
import 'package:legalz_hub_app/screens/tabs/payment_tab/widgets/bottom_payment.dart';
import 'package:legalz_hub_app/screens/tabs/payment_tab/widgets/payment_header_view.dart';
import 'package:legalz_hub_app/screens/tabs/payment_tab/widgets/payment_list_view.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/shared_widget/main_header_view.dart';
import 'package:legalz_hub_app/shared_widget/shimmers/shimmer_notifications.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/logger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentTabScreen extends StatefulWidget {
  const PaymentTabScreen({super.key});

  @override
  State<PaymentTabScreen> createState() => _PaymentTabScreenState();
}

class _PaymentTabScreenState extends State<PaymentTabScreen> with TickerProviderStateMixin {
  final bloc = PaymentsBloc();

  @override
  void didChangeDependencies() {
    logDebugMessage(message: 'Payments init Called ...');
    bloc.getListOfPayments();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MainHeaderView(
          userType: UserType.attorney,
          refreshCallBack: () {
            bloc.getListOfPayments();
          },
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ValueListenableBuilder<List<PaymentResponseData>>(
            valueListenable: bloc.paymentListNotifier,
            builder: (context, snapshot, child) {
              return snapshot != []
                  ? Column(
                      children: [
                        PaymentHeaderView(
                          pendingAmount: bloc.pendingTotalAmount,
                          recivedAmount: bloc.recivedTotalAmount,
                          currency: bloc.currency,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomText(
                                title: AppLocalizations.of(context)!.detailspayments,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                textColor: const Color(0xff444444),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                PaymentBottomSheetsUtil().info(context);
                              },
                              icon: const Icon(
                                Icons.info,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: PaymentListView(
                            list: snapshot,
                            onReportPressed: (item) {
                              _displayReportDialog(context, item.id!);
                            },
                          ),
                        ),
                      ],
                    )
                  : const ShimmerNotificationsView();
            },
          ),
        ),
      ],
    );
  }

  Future<void> _displayReportDialog(BuildContext context, int itemId) async {
    TextEditingController controller = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: CustomText(
              title: AppLocalizations.of(context)!.reportanproblem,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              textColor: const Color(0xff444444),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: controller,
                maxLines: 3,
                decoration: InputDecoration(hintText: AppLocalizations.of(context)!.describeyourproblem),
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text(AppLocalizations.of(context)!.cancel),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                child: Text(AppLocalizations.of(context)!.submit),
                onPressed: () {
                  setState(() {
                    bloc.reportPayment(itemId, controller.text).whenComplete(() {
                      Navigator.pop(context);
                      bloc.getListOfPayments();
                    });
                  });
                },
              ),
            ],
          );
        });
  }
}
