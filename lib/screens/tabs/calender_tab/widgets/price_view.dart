import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class PriceView extends StatelessWidget {
  const PriceView(
      {super.key,
      required this.priceBeforeDiscount,
      required this.priceAfterDiscount,
      required this.currency});
  final double priceBeforeDiscount;
  final double priceAfterDiscount;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          CustomText(
            title: AppLocalizations.of(context)!.price,
            fontSize: 14,
            textColor: const Color(0xff554d56),
          ),
          Expanded(child: const SizedBox()),
          Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '$priceBeforeDiscount $currency',
                  style: const TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                TextSpan(
                  text: "$priceAfterDiscount $currency",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
