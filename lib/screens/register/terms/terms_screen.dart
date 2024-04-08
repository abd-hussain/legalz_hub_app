import 'package:flutter/material.dart';
import 'package:legalz_hub_app/screens/register/terms/terms_bloc.dart';
import 'package:legalz_hub_app/shared_widget/custom_appbar.dart';
import 'package:legalz_hub_app/shared_widget/custom_button.dart';
import 'package:legalz_hub_app/utils/constants/constant.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/push_notifications/firebase_cloud_messaging_util.dart';
import 'package:legalz_hub_app/utils/routes.dart';
import 'package:lottie/lottie.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({super.key});

  @override
  State<TermsAndConditionScreen> createState() =>
      _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  final bloc = RegisterTermsBloc();

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        FirebaseCloudMessagingUtil.initConfigure(context);
      });
    });

    bloc.handleReadingArguments(
        arguments: ModalRoute.of(context)!.settings.arguments);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: AppLocalizations.of(context)!.termsandconditions,
        userType: bloc.userType ?? UserType.customer,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: Lottie.asset(
                'assets/lottie/68469-pen-writing-lottie-animation.zip',
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff444444))),
              child: WebViewAware(
                child: WebViewX(
                  key: const ValueKey('webviewx'),
                  ignoreAllGestures: false,
                  initialSourceType: SourceType.urlBypass,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  onWebViewCreated: (controller) async {
                    bloc.webviewController = controller;
                    bloc.webviewController.loadContent(
                      bloc.box.get(DatabaseFieldConstant.language) == "en"
                          ? AppConstant.termsLink
                          : AppConstant.termsLinkAR,
                      sourceType: SourceType.urlBypass,
                    );
                  },
                ),
              ),
            ),
          ),
          CustomButton(
            enableButton: true,
            buttonTitle: AppLocalizations.of(context)!.acceptandcontinue,
            onTap: () {
              Navigator.pop(context);

              if (bloc.userType != null) {
                if (bloc.userType == UserType.attorney) {
                  bloc.box
                      .put(DatabaseFieldConstant.attorneyRegistrationStep, "1");
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(RoutesConstants.registerAttornyFaze1Screen);
                } else {
                  bloc.box
                      .put(DatabaseFieldConstant.customerRegistrationStep, "1");
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(RoutesConstants.registerCustomerFaze1Screen);
                }
              }
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
