import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class DotsIndicator extends AnimatedWidget {
  final PageController controller;
  final ValueChanged<int> onPageSelected;
  final Function() skipPressed;

  const DotsIndicator({
    super.key,
    required this.skipPressed,
    required this.controller,
    required this.onPageSelected,
  }) : super(listenable: controller);

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2 - 1.0) * selectedness;
    return SizedBox(
      width: 25,
      child: Center(
        child: Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: SizedBox(
            width: 8 * zoom,
            height: 8 * zoom,
            child: InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () => skipPressed(),
          child: CustomText(
            title: AppLocalizations.of(context)!.skip,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            textColor: Colors.white,
          ),
        ),
        const Expanded(child: SizedBox()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(5, _buildDot),
        ),
      ],
    );
  }
}
