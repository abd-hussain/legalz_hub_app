import 'package:flutter/material.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/utils/constants/constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:share_plus/share_plus.dart';

class ClientShareView extends StatelessWidget {
  final String invitationCode;
  const ClientShareView({super.key, required this.invitationCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
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
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  "assets/images/logoz/logo-color.png",
                  width: MediaQuery.of(context).size.width / 4,
                ),
              ),
              CustomText(
                title: AppLocalizations.of(context)!.clientapp,
                fontSize: 18,
                textColor: const Color(0xff444444),
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                title: AppLocalizations.of(context)!.clientappdesc,
                fontSize: 14,
                maxLins: 4,
                textAlign: TextAlign.center,
                textColor: const Color(0xff444444),
              ),
              const Divider(),
              CustomText(
                title: AppLocalizations.of(context)!.invitationcodeinvite,
                fontSize: 14,
                maxLins: 2,
                textAlign: TextAlign.center,
                textColor: const Color(0xff444444),
              ),
              CustomText(
                title: invitationCode,
                fontSize: 18,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
                textColor: const Color(0xff444444),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                  child: const Icon(
                    Icons.share,
                    color: Color(0xff034061),
                  ),
                  onPressed: () async {
                    await Share.shareWithResult(
                        "${AppLocalizations.of(context)!.messageforshareclient} {$invitationCode} - iOS : ${AppConstant.appLinkIos} , android : ${AppConstant.appLinkAndroid}");
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
