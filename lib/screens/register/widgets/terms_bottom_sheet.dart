import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:legalz_hub_app/shared_widget/custom_button.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/utils/constants/constant.dart';
import 'package:lottie/lottie.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class TermsRegisterBottomSheetsUtil {
  final BuildContext context;
  final String language;
  TermsRegisterBottomSheetsUtil({required this.language, required this.context});

  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {Factory(() => EagerGestureRecognizer())};
  late WebViewXController controller;

  Future bottomSheet({required Function() approved}) async {
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
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 20),
          child: Wrap(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  const Expanded(child: SizedBox()),
                  CustomText(
                    title: AppLocalizations.of(context)!.termsandconditions,
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
              const SizedBox(height: 8),
              Center(
                child: SizedBox(
                  height: 120,
                  width: 120,
                  child: Lottie.asset(
                    'assets/lottie/68469-pen-writing-lottie-animation.zip',
                  ),
                ),
              ),
              Container(
                height: 300,
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(border: Border.all(color: const Color(0xff444444))),
                child: WebViewAware(
                  child: WebViewX(
                    initialSourceType: SourceType.url,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    onPageStarted: (value) {},
                    onWebViewCreated: (contr) {
                      controller = contr;
                      controller.loadContent(
                        language == "ar" ? AppConstant.termsLinkAR : AppConstant.termsLink,
                        sourceType: SourceType.url,
                      );
                    },
                  ),
                ),
              ),
              CustomButton(
                enableButton: true,
                buttonTitle: AppLocalizations.of(context)!.acceptandcontinue,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Future termsBottomSheet({required Function() openNext}) async {
  //   if (kIsWeb) {
  //     //   // ignore: undefined_prefixed_name
  //     //   ui.platformViewRegistry.registerViewFactory(
  //     //       'terms-html',
  //     //       (int viewId) => IFrameElement()
  //     //         ..width = '640'
  //     //         ..height = '360'
  //     //         ..src = AppConstant.termsLink
  //     //         ..style.border = 'none');
  //   }

  //   return await showModalBottomSheet(
  //       isScrollControlled: true,
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(
  //           top: Radius.circular(25),
  //         ),
  //       ),
  //       enableDrag: true,
  //       useRootNavigator: true,
  //       context: context,
  //       backgroundColor: Colors.white,
  //       clipBehavior: Clip.antiAliasWithSaveLayer,
  //       builder: (context) {
  //         return Padding(
  //           padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 20),
  //           child: Wrap(
  //             children: [

  //             ],
  //           ),
  //         );
  //       });
  // }
}
