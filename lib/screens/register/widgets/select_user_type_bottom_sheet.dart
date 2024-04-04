import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:legalz_hub_app/shared_widget/custom_button.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectUserTypeRegisterBottomSheetsUtil {
  final BuildContext context;

  SelectUserTypeRegisterBottomSheetsUtil({required this.context});

  Future infoBottomSheet({required Function(UserType) openNext}) async {
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
                  title: AppLocalizations.of(context)!.registertypetitle,
                  textColor: const Color(0xff444444),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Center(
                child: CustomText(
                  title: AppLocalizations.of(context)!.registertypedesc,
                  textColor: const Color(0xff444444),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              CustomButton(
                enableButton: true,
                buttonTitle: AppLocalizations.of(context)!.customeruser,
                buttonColor: Colors.blueAccent,
                buttonTitleColor: Colors.white,
                onTap: () {
                  Navigator.pop(context);
                  openNext(UserType.customer);
                },
              ),
              CustomButton(
                enableButton: true,
                buttonTitle: AppLocalizations.of(context)!.attorneyuser,
                buttonColor: Colors.black,
                buttonTitleColor: Colors.white,
                onTap: () {
                  Navigator.pop(context);
                  openNext(UserType.attorney);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };
}
