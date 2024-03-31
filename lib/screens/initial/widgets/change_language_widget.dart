import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeLanguageWidget extends StatelessWidget {
  final int selectionIndex;
  final Function(int) segmentChange;
  const ChangeLanguageWidget({super.key, required this.selectionIndex, required this.segmentChange});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          children: [
            CustomText(
              title: AppLocalizations.of(context)!.selectfavlanguage,
              fontSize: 15,
              textColor: const Color(0xff034061),
              fontWeight: FontWeight.bold,
            ),
            MaterialSegmentedControl(
              children: const {
                0: SizedBox(
                  width: 120,
                  height: 30,
                  child: Center(
                    child: CustomText(
                      title: 'English',
                      fontSize: 16,
                    ),
                  ),
                ),
                1: SizedBox(
                  width: 120,
                  height: 30,
                  child: Center(
                      child: CustomText(
                    title: 'العربية',
                    fontSize: 16,
                  )),
                ),
              },
              selectionIndex: selectionIndex,
              selectedColor: const Color(0xff034061),
              unselectedColor: const Color(0xffD9D9D9),
              borderRadius: 8.0,
              horizontalPadding: const EdgeInsets.all(25.0),
              verticalOffset: 8.0,
              onSegmentTapped: (index) async {
                segmentChange(index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
