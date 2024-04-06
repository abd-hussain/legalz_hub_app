import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/utils/constants/constant.dart';
import 'package:legalz_hub_app/utils/routes.dart';
import 'package:legalz_hub_app/utils/version.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterView extends StatelessWidget {
  final String language;
  const FooterView({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context, rootNavigator: true)
                    .pushNamed(RoutesConstants.webViewScreen, arguments: {
                  AppConstant.webViewPageUrl: AppConstant.facebookLink,
                  AppConstant.pageTitle: AppLocalizations.of(context)!.facebook
                }),
                child: const Icon(
                  Ionicons.logo_facebook,
                  color: Color(0xff444444),
                ),
              ),
              const CustomText(
                title: "|",
                fontSize: 16,
                textColor: Color(0xff444444),
                fontWeight: FontWeight.bold,
              ),
              TextButton(
                onPressed: () => _launchWhatsapp(context),
                child: const Icon(
                  Ionicons.logo_whatsapp,
                  color: Color(0xff444444),
                ),
              ),
              const CustomText(
                title: "|",
                fontSize: 16,
                textColor: Color(0xff444444),
                fontWeight: FontWeight.bold,
              ),
              TextButton(
                onPressed: () => Navigator.of(context, rootNavigator: true)
                    .pushNamed(RoutesConstants.webViewScreen, arguments: {
                  AppConstant.webViewPageUrl: AppConstant.linkedinLink,
                  AppConstant.pageTitle: AppLocalizations.of(context)!.linkedin
                }),
                child: const Icon(
                  Ionicons.logo_linkedin,
                  color: Color(0xff444444),
                ),
              ),
            ],
          ),
          kIsWeb
              ? Container()
              : TextButton(
                  onPressed: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) async {
                      RateMyApp().showRateDialog(
                        context,
                        title: AppLocalizations.of(context)!.rateapponstore,
                        message:
                            AppLocalizations.of(context)!.rateapponstoremessage,
                        rateButton: AppLocalizations.of(context)!.rateapp,
                        laterButton: AppLocalizations.of(context)!.later,
                        noButton: AppLocalizations.of(context)!.close,
                      );
                    });
                  },
                  child:
                      _footerTextWidget(AppLocalizations.of(context)!.rateapp),
                ),
          TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(RoutesConstants.webViewScreen, arguments: {
                AppConstant.webViewPageUrl: language == "en"
                    ? AppConstant.termsLink
                    : AppConstant.termsLinkAR,
                AppConstant.pageTitle:
                    AppLocalizations.of(context)!.termsandconditions
              });
            },
            child: _footerTextWidget(
                AppLocalizations.of(context)!.termsandconditions),
          ),
          TextButton(
            onPressed: () => Navigator.of(context, rootNavigator: true)
                .pushNamed(RoutesConstants.webViewScreen, arguments: {
              AppConstant.webViewPageUrl: language == "en"
                  ? AppConstant.privacypolicyLink
                  : AppConstant.privacypolicyLinkAR,
              AppConstant.pageTitle: AppLocalizations.of(context)!.privacypolicy
            }),
            child:
                _footerTextWidget(AppLocalizations.of(context)!.privacypolicy),
          ),
          const SizedBox(height: 16),
          FutureBuilder<String>(
              initialData: "",
              future: Version().getApplicationVersion(),
              builder: (context, snapshot) {
                return CustomText(
                  title:
                      "${AppLocalizations.of(context)!.version} ${snapshot.data}",
                  fontSize: 12,
                  textColor: const Color(0xffBFBFBF),
                );
              }),
          const SizedBox(height: 20),
          CustomText(
            title: AppLocalizations.of(context)!.rightsreserved,
            fontSize: 10,
            textColor: const Color(0xff707070),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _footerTextWidget(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          title: title,
          fontSize: 10,
          textColor: const Color(0xff444444),
        ),
        const Icon(
          Icons.arrow_forward_rounded,
          size: 10,
          color: Color(0xff444444),
        )
      ],
    );
  }

  void _launchWhatsapp(BuildContext context) async {
    final localize = AppLocalizations.of(context)!;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    var whatsapp = AppConstant.whatsappNumber;
    var whatsappAndroid =
        Uri.parse("whatsapp://send?phone=$whatsapp&text=hello");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(localize.whatsappnotinstalled),
        ),
      );
    }
  }
}
