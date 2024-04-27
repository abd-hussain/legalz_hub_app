import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/shared_widget/points_in_last_view.dart';
import 'package:lottie/lottie.dart';

class InfoWorkingHourBottomSheetsUtil {
  Future info(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        enableDrag: true,
        useRootNavigator: true,
        context: context,
        backgroundColor: Colors.white,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context) {
          return Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
            child: Wrap(
              spacing: 8,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                    const Expanded(child: SizedBox()),
                    CustomText(
                      title: AppLocalizations.of(context)!.infox,
                      textColor: Colors.black,
                      fontSize: 18,
                    ),
                    const Expanded(child: SizedBox()),
                    const SizedBox(width: 50),
                  ],
                ),
                Center(
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Lottie.asset(
                      'assets/lottie/69678-save-money.zip',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                PointsInLastViewBooking(
                  number: "1",
                  text: AppLocalizations.of(context)!.workinghourstext1,
                ),
                PointsInLastViewBooking(
                  number: AppLocalizations.of(context)!.example,
                  text: AppLocalizations.of(context)!.workinghourstext1example,
                ),
                const SizedBox(height: 20),
                PointsInLastViewBooking(
                  number: "2",
                  text: AppLocalizations.of(context)!.workinghourstext2,
                ),
                const SizedBox(height: 20),
                PointsInLastViewBooking(
                  number: "3",
                  text: AppLocalizations.of(context)!.workinghourstext3,
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        });
  }
}
