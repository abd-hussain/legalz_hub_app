import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/models/gender_model.dart';
import 'package:legalz_hub_app/models/https/countries_model.dart';
import 'package:legalz_hub_app/models/https/suffix_model.dart';
import 'package:legalz_hub_app/models/working_hours.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class BottomSheetsUtil {
  Future addImageBottomSheet(
      BuildContext context, bool? image, String title1, String title2,
      {required VoidCallback galleryCallBack,
      required VoidCallback cameraCallBack,
      required VoidCallback deleteCallBack}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(18),
            child: image!
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        title: title1,
                        textColor: Colors.black,
                        fontSize: 18,
                      ),
                      const SizedBox(height: 27),
                      TextButton(
                        onPressed: () {
                          deleteCallBack();
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.hide_image,
                              color: Color(0xff4CB6EA),
                            ),
                            const SizedBox(width: 10),
                            CustomText(
                              title: AppLocalizations.of(context)!
                                  .pickimageremoveimage,
                              textColor: Colors.red,
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        title: title2,
                        textColor: Colors.black,
                        fontSize: 18,
                      ),
                      const SizedBox(height: 27),
                      SizedBox(
                        height: 100,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                                galleryCallBack();
                              },
                              child: SizedBox(
                                height: 50,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Icon(
                                        Icons.image_outlined,
                                        color: Color(0xff444444),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: CustomText(
                                        title: AppLocalizations.of(context)!
                                            .pickimagefromstudio,
                                        fontSize: 16,
                                        textColor: const Color(0xff444444),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                                cameraCallBack();
                              },
                              child: SizedBox(
                                height: 50,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          color: Color(0xff444444),
                                        )),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: CustomText(
                                        title: AppLocalizations.of(context)!
                                            .pickimagefromcamera,
                                        fontSize: 16,
                                        textColor: const Color(0xff444444),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),
                    ],
                  ),
          );
        });
  }

  Future genderBottomSheet(BuildContext context, List<Gender> listOfGender,
      Function(Gender) selectedGender) {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  title: AppLocalizations.of(context)!.genderprofile,
                  textColor: Colors.black,
                  fontSize: 20,
                ),
                const SizedBox(height: 27),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    itemCount: listOfGender.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          selectedGender(listOfGender[index]);
                        },
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: listOfGender[index].icon),
                              const SizedBox(width: 8),
                              Expanded(
                                child: CustomText(
                                  title: listOfGender[index].name,
                                  fontSize: 16,
                                  textColor: const Color(0xff444444),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        });
  }

  Future countryBottomSheet(BuildContext context, List<Country> listOfCountries,
      Function(Country) selectedCountry) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomText(
                title: AppLocalizations.of(context)!.selectCountry,
                textColor: Colors.black,
                fontSize: 20,
              ),
              const SizedBox(height: 27),
              SizedBox(
                height: 200,
                child: ListView.builder(
                    itemCount: listOfCountries.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          selectedCountry(listOfCountries[index]);
                        },
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: FadeInImage(
                                  placeholder: const AssetImage(
                                      "assets/images/flagPlaceHolderImg.png"),
                                  image: NetworkImage(
                                    listOfCountries[index].flagImage!,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: CustomText(
                                  title: listOfCountries[index].name!,
                                  fontSize: 16,
                                  textColor: const Color(0xff444444),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Future suffixBottomSheet(BuildContext context, List<SuffixData> listOfSuffix,
      Function(SuffixData) selectedSuffix) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomText(
                title: AppLocalizations.of(context)!.selectSuffix,
                textColor: Colors.black,
                fontSize: 20,
              ),
              const SizedBox(height: 27),
              SizedBox(
                height: 200,
                child: ListView.builder(
                    itemCount: listOfSuffix.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          selectedSuffix(listOfSuffix[index]);
                        },
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomText(
                                  title: listOfSuffix[index].name!,
                                  fontSize: 16,
                                  textColor: const Color(0xff444444),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Future speakingLanguageBottomSheet(
      {required BuildContext context,
      required List<CheckBox> listOfLanguage,
      required Function(List<CheckBox>) onSave}) {
    final StreamController<bool> valueListenable =
        StreamController<bool>.broadcast();

    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    title: AppLocalizations.of(context)!.speakinglanguage,
                    textColor: Colors.black,
                    fontSize: 18,
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: InkWell(
                      onTap: () {
                        onSave(listOfLanguage);
                        Navigator.pop(context);
                      },
                      child: CustomText(
                        title: AppLocalizations.of(context)!.save,
                        textColor: const Color(0xff444444),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  height: 300,
                  child: ListView.builder(
                      itemCount: listOfLanguage.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              title: listOfLanguage[index].value,
                              textColor: Colors.black,
                              fontSize: 18,
                            ),
                            StreamBuilder<bool>(
                                stream: valueListenable.stream,
                                builder: (context, snapshot) {
                                  return Checkbox(
                                      value: listOfLanguage[index].isEnable,
                                      onChanged: (va) {
                                        listOfLanguage[index].isEnable =
                                            !listOfLanguage[index].isEnable;
                                        valueListenable.sink.add(true);
                                      });
                                }),
                          ],
                        );
                      }),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Future areYouShoureButtomSheet(
      {required BuildContext context,
      required String message,
      required VoidCallback sure}) {
    return showModalBottomSheet(
      enableDrag: false,
      useRootNavigator: true,
      context: context,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) {
        return SafeArea(
          child: SizedBox(
            height: 175,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    height: 120,
                    width: double.infinity,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: CustomText(
                            title: message,
                            textColor: const Color(0xff191C1F),
                            maxLins: 3,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Divider(
                          height: 1,
                          color: Color(0xffEBEBEB),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Material(
                            borderRadius: BorderRadius.circular(8),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                Navigator.pop(context);
                                sure();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                child: CustomText(
                                  title: AppLocalizations.of(context)!.sure,
                                  textColor: const Color(0xffE74C4C),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    child: Material(
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.white,
                          height: 50,
                          width: double.infinity,
                          child: CustomText(
                            title: AppLocalizations.of(context)!.cancel,
                            textColor: const Color(0xff1A59B9),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
