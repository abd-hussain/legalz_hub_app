import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/screens/rate_per_hour/widgets/calculation_hours_view.dart';
import 'package:legalz_hub_app/screens/rate_per_hour/widgets/promo_code_view.dart';
import 'package:legalz_hub_app/screens/rate_per_hour/widgets/segment_free_view.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/shared_widget/custom_textfield.dart';

class HourRateView extends StatefulWidget {
  const HourRateView(
      {super.key,
      required this.controller,
      required this.onTapPlus,
      required this.onTapMinus,
      required this.currency,
      required this.freeType,
      required this.freeCallTypeSelected});
  final TextEditingController controller;
  final String currency;
  final int freeType;
  final Function() onTapPlus;
  final Function() onTapMinus;
  final Function(int) freeCallTypeSelected;

  @override
  State<HourRateView> createState() => _HourRateViewState();
}

class _HourRateViewState extends State<HourRateView> {
  double recumendedRatePerHour = 16;
  ValueNotifier<String> valueEntered = ValueNotifier<String>("16.0");
  ValueNotifier<int> selectedFreeType = ValueNotifier<int>(0);

  @override
  void initState() {
    widget.controller.addListener(() {
      valueEntered.value = widget.controller.text;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.5,
            blurRadius: 5,
            offset: const Offset(0, 0.1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomText(
              title: AppLocalizations.of(context)!.rateperhourdesc1,
              fontSize: 14,
              maxLins: 3,
              textColor: const Color(0xff444444),
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 20),
            CustomText(
              title: AppLocalizations.of(context)!.rateperhourdesc2,
              fontSize: 14,
              maxLins: 3,
              textAlign: TextAlign.center,
              textColor: const Color(0xff444444),
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 20),
            CustomText(
              title: AppLocalizations.of(context)!.rateperhourdesc3,
              fontSize: 14,
              maxLins: 3,
              textAlign: TextAlign.center,
              textColor: const Color(0xff444444),
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 20),
            CustomText(
              title: "$recumendedRatePerHour ${widget.currency}",
              fontSize: 16,
              textAlign: TextAlign.center,
              textColor: const Color(0xff444444),
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.grey[200],
                    child: IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () => widget.onTapMinus(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: CustomTextField(
                    controller: widget.controller,
                    hintText: AppLocalizations.of(context)!.rateperhour,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(4),
                    ],
                    fontSize: 18,
                    textAlign: TextAlign.center,
                    padding: EdgeInsets.zero,
                    onEditingComplete: () {
                      if (widget.controller.text.isEmpty) {
                        widget.controller.text = "0.0";
                      }
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.grey[200],
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => widget.onTapPlus(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ValueListenableBuilder<String>(
                valueListenable: valueEntered,
                builder: (context, snapshot, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title: AppLocalizations.of(context)!.calculations,
                        fontSize: 14,
                        textColor: const Color(0xff444444),
                        fontWeight: FontWeight.bold,
                      ),
                      CalculationHoursView(
                        timing: AppLocalizations.of(context)!.quarter,
                        currency: widget.currency,
                        value: calculateQuarter(snapshot),
                        onPress: () {},
                      ),
                      CalculationHoursView(
                        timing: AppLocalizations.of(context)!.half,
                        currency: widget.currency,
                        value: calculateHalf(snapshot),
                        onPress: () {},
                      ),
                      CalculationHoursView(
                        timing: AppLocalizations.of(context)!.threequarter,
                        currency: widget.currency,
                        value: calculate3Quarter(snapshot),
                        onPress: () {},
                      ),
                      CalculationHoursView(
                        timing: AppLocalizations.of(context)!.one,
                        currency: widget.currency,
                        value: calculate4Quarter(snapshot),
                        onPress: () {},
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8),
                        child: Container(height: 1, color: Colors.grey[300]),
                      ),
                      FreeCallSegmentedView(
                          freeType: widget.freeType,
                          freeCallTypeSelected: (type) {
                            selectedFreeType.value = type;
                            widget.freeCallTypeSelected(type);
                          }),
                      ValueListenableBuilder<int>(
                          valueListenable: selectedFreeType,
                          builder: (context, snapshot, child) {
                            if (snapshot == 3) {
                              return PromoCodeView(
                                controller: TextEditingController(text: ""),
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }

  String calculateHalf(String value) {
    double val = double.parse(value == "" ? "0" : value);
    val = val / 2;
    return "$val";
  }

  String calculateQuarter(String value) {
    double val = double.parse(value == "" ? "0" : value);
    val = val / 4;
    return "$val";
  }

  String calculate3Quarter(String value) {
    double val = double.parse(value == "" ? "0" : value);
    val = val / 4 * 3;
    return "$val";
  }

  String calculate4Quarter(String value) {
    final double val = double.parse(value == "" ? "0" : value);
    return "$val";
  }
}
