import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class PaymentHeaderView extends StatelessWidget {
  const PaymentHeaderView({
    super.key,
    required this.pendingAmount,
    required this.recivedAmount,
    required this.currency,
  });
  final double pendingAmount;
  final double recivedAmount;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        height: 70,
        child: Row(
          children: [
            item(AppLocalizations.of(context)!.pending, pendingAmount,
                Colors.orange),
            const SizedBox(width: 16),
            item(AppLocalizations.of(context)!.recived, recivedAmount,
                Colors.green),
          ],
        ),
      ),
    );
  }

  Widget item(String title, double amount, Color color) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                title: "$amount $currency",
                fontSize: 16,
                fontWeight: FontWeight.bold,
                textColor: const Color(0xff444444),
              ),
              const SizedBox(height: 4),
              CustomText(
                title: title,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                textColor: color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
