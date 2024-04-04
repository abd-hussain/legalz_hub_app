import 'package:flutter/material.dart';
import 'package:legalz_hub_app/screens/register/widgets/points_view.dart';
import 'package:legalz_hub_app/screens/register/widgets/terms_bottom_sheet.dart';
import 'package:legalz_hub_app/shared_widget/custom_button.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/utils/routes.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterCustomerBottomSheetsUtil {
  final BuildContext context;
  final String language;

  RegisterCustomerBottomSheetsUtil(
      {required this.language, required this.context});

  Future infoBottomSheet(
      {required int step, required Function() openNext}) async {
    return await showModalBottomSheet(
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
              const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 20),
          child: Wrap(
            children: [
              Row(
                children: [
                  const SizedBox(width: 50),
                  const Expanded(child: SizedBox()),
                  CustomText(
                    title: AppLocalizations.of(context)!.registernow,
                    textColor: const Color(0xff444444),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              Center(
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Lottie.asset(
                    'assets/lottie/104759-login.zip',
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: CustomText(
                  title: AppLocalizations.of(context)!.registertitlecustomer,
                  textColor: const Color(0xff444444),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Center(
                child: CustomText(
                  title: AppLocalizations.of(context)!.registertitledesc,
                  textColor: const Color(0xff444444),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              PointsViewBooking(
                number: step >= 1 ? "*" : "1",
                text: AppLocalizations.of(context)!.registerstep1,
                textColor: step >= 1 ? Colors.green : const Color(0xff444444),
                onPress: () {
                  TermsRegisterBottomSheetsUtil(
                          context: context, language: language)
                      .bottomSheet(approved: () {});
                },
              ),
              const SizedBox(height: 20),
              PointsViewBooking(
                number: step >= 2 ? "*" : "2",
                text: AppLocalizations.of(context)!.registerstep2,
                textColor: step >= 2 ? Colors.green : const Color(0xff444444),
                onPress: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(RoutesConstants.registerCustomerFaze1Screen);
                },
              ),
              const SizedBox(height: 20),
              PointsViewBooking(
                number: step >= 6 ? "*" : "3",
                text: AppLocalizations.of(context)!.registerstep6,
                textColor: step >= 6 ? Colors.green : const Color(0xff444444),
                onPress: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(RoutesConstants.registerCustomerFaze2Screen);
                },
              ),
              const SizedBox(height: 20),
              PointsViewBooking(
                number: step >= 7 ? "*" : "4",
                text: AppLocalizations.of(context)!.registerstep7,
                textColor: step >= 7 ? Colors.green : const Color(0xff444444),
                onPress: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(RoutesConstants.registerfinalfazeScreen);
                },
              ),
              CustomButton(
                enableButton: true,
                buttonTitle: AppLocalizations.of(context)!.registerAccount,
                onTap: () {
                  Navigator.pop(context);
                  openNext();
                },
              ),
              CustomButton(
                enableButton: true,
                buttonTitle: AppLocalizations.of(context)!.cancelRegistration,
                buttonColor: Colors.red,
                onTap: () {
                  Navigator.pop(context);
                  openNext();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
