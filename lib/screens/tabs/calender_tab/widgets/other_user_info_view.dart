import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/utils/constants/constant.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';

class OtherUserInfoView extends StatelessWidget {
  final String? profileImg;
  final String? flagImage;
  final String? suffixName;
  final String? firstName;
  final String? lastName;
  final String? categoryName;
  final String? gender;
  final String? dateOfBirth;
  final UserType userType;

  const OtherUserInfoView({
    super.key,
    required this.profileImg,
    required this.flagImage,
    required this.suffixName,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.categoryName,
    required this.dateOfBirth,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                    backgroundColor: userType == UserType.customer
                        ? const Color(0xff292929)
                        : const Color(0xff034061),
                    radius: 30,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: profileImg != ""
                          ? FadeInImage(
                              placeholder:
                                  const AssetImage("assets/images/avatar.jpeg"),
                              image: userType == UserType.customer
                                  ? NetworkImage(
                                      AppConstant.imagesBaseURLForCustomer +
                                          profileImg!,
                                      scale: 1,
                                    )
                                  : NetworkImage(
                                      AppConstant.imagesBaseURLForAttorney +
                                          profileImg!,
                                      scale: 1,
                                    ),
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
                        child: flagImage != ""
                            ? FadeInImage(
                                placeholder: const AssetImage(
                                    "assets/images/avatar.jpeg"),
                                image: NetworkImage(
                                    AppConstant.imagesBaseURLForCountries +
                                        flagImage!,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: userType == UserType.customer
                        ? "$firstName $lastName"
                        : "$suffixName $firstName $lastName",
                    textColor: const Color(0xff444444),
                    fontSize: 14,
                    textAlign: TextAlign.center,
                    maxLins: 4,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 8),
                  categoryName != ""
                      ? Row(
                          children: [
                            Text("${AppLocalizations.of(context)!.category}: "),
                            Text(categoryName!),
                          ],
                        )
                      : Container(),
                  Row(
                    children: [
                      Text("${AppLocalizations.of(context)!.gender}: "),
                      Text(gender!),
                    ],
                  ),
                  dateOfBirth != ""
                      ? Row(
                          children: [
                            Text(
                                "${AppLocalizations.of(context)!.dateofbirth}: "),
                            Text(dateOfBirth!),
                          ],
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
