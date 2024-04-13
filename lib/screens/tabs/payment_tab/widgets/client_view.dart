import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/utils/constants/constant.dart';

class ClientView extends StatelessWidget {
  final String clientProfileImg;
  final String clientFirstName;
  final String clientLastName;
  final String clientCountryFlag;

  const ClientView(
      {super.key,
      required this.clientProfileImg,
      required this.clientFirstName,
      required this.clientLastName,
      required this.clientCountryFlag});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CustomText(
            title: AppLocalizations.of(context)!.callwith,
            fontSize: 14,
            textColor: const Color(0xff444444),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color(0xff034061),
                        radius: 30,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: clientProfileImg != ""
                              ? FadeInImage(
                                  placeholder: const AssetImage(
                                      "assets/images/avatar.jpeg"),
                                  image: NetworkImage(
                                      AppConstant.imagesBaseURLForCustomer +
                                          clientProfileImg,
                                      scale: 1),
                                )
                              : Image.asset(
                                  'assets/images/avatar.jpeg',
                                  width: 110.0,
                                  height: 110.0,
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                      Positioned(
                        left: 8,
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 10,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: clientCountryFlag != ""
                                ? FadeInImage(
                                    placeholder: const AssetImage(
                                        "assets/images/avatar.jpeg"),
                                    image: NetworkImage(
                                        AppConstant.imagesBaseURLForCountries +
                                            clientCountryFlag,
                                        scale: 1),
                                  )
                                : Image.asset(
                                    'assets/images/avatar.jpeg',
                                    width: 110.0,
                                    height: 110.0,
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 4),
                  CustomText(
                    title: "$clientFirstName $clientLastName",
                    textColor: const Color(0xff444444),
                    fontSize: 14,
                    textAlign: TextAlign.center,
                    maxLins: 4,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
