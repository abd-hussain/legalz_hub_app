import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class ReviewHeaderView extends StatelessWidget {
  const ReviewHeaderView({required this.ratesCount, required this.totalRates, super.key});
  final int ratesCount;
  final double totalRates;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Column(
            children: [
              CustomText(
                title: AppLocalizations.of(context)!.ratecount,
                fontSize: 12,
                textColor: const Color(0xff554d56),
              ),
              const SizedBox(height: 8),
              CustomText(
                title: ratesCount.toString(),
                fontSize: 25,
                fontWeight: FontWeight.bold,
                textColor: const Color(0xff554d56),
              ),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                CustomText(
                  title: AppLocalizations.of(context)!.rateaverage,
                  fontSize: 12,
                  textColor: const Color(0xff554d56),
                ),
                const SizedBox(height: 4),
                RatingBarIndicator(
                  rating: totalRates,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemSize: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
