import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/models/https/categories_model.dart';
import 'package:legalz_hub_app/shared_widget/booking/widgets/cell_of_booking.dart';
import 'package:legalz_hub_app/shared_widget/booking/widgets/parser.dart';
import 'package:legalz_hub_app/shared_widget/booking/widgets/points_in_last_view.dart';
import 'package:legalz_hub_app/shared_widget/custom_button.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/utils/currency.dart';

enum InstanceBookingFaze { one, two, three }

class InstantBookingBottomSheetsUtil {
  ValueNotifier<Category?> selectedCategory = ValueNotifier<Category?>(null);
  ValueNotifier<Timing> selectedMeetingDuration =
      ValueNotifier<Timing>(Timing.halfHour);
  ValueNotifier<InstanceBookingFaze> registrationFase =
      ValueNotifier<InstanceBookingFaze>(InstanceBookingFaze.one);

  Future bookMeetingBottomSheet({
    required BuildContext context,
    required List<Category> listOfCategories,
    required Function(Category selectedCategory, Timing selectedMeetingDuration)
        onEndSelection,
  }) async {
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
              const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 20),
          child: Wrap(children: [
            Row(
              children: [
                const SizedBox(width: 50),
                const Expanded(child: SizedBox()),
                CustomText(
                  title: AppLocalizations.of(context)!.meetingnow,
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
            ValueListenableBuilder<InstanceBookingFaze>(
                valueListenable: registrationFase,
                builder: (context, snapshotFase, child) {
                  return Column(
                    children: [
                      Center(
                        child: CustomText(
                          title: faseTitle(snapshotFase),
                          textColor: const Color(0xff444444),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      showCorrectViewDependOnFase(
                          fase: snapshotFase,
                          context: context,
                          listOfCategories: listOfCategories,
                          onEndSelection: (categoty, time) {
                            Navigator.pop(context);
                            onEndSelection(categoty, time);
                          })
                    ],
                  );
                }),
          ]),
        );
      },
    );
  }

  Widget faze1View({
    required BuildContext context,
    required List<Category> listOfCategories,
  }) {
    return ValueListenableBuilder<Category?>(
        valueListenable: selectedCategory,
        builder: (context, selectedCategoriesSnapshot, child) {
          return Column(
            children: [
              const SizedBox(height: 10),
              CustomText(
                title: "-- ${AppLocalizations.of(context)!.specialist} --",
                textColor: const Color(0xff444444),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 400,
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                            childAspectRatio: 1,
                            mainAxisExtent: 100),
                    itemCount: listOfCategories.length,
                    itemBuilder: (context, index) {
                      return BookingCell(
                        title: listOfCategories[index].name!,
                        isSelected: selectedCategoriesSnapshot != null
                            ? selectedCategoriesSnapshot ==
                                listOfCategories[index]
                            : false,
                        onPress: () {
                          selectedCategory.value = listOfCategories[index];
                        },
                      );
                    }),
              ),
              const SizedBox(height: 8),
              footerBottomSheet(
                context: context,
                categoryName: selectedCategoriesSnapshot != null
                    ? selectedCategoriesSnapshot.name!
                    : "",
                duration: "",
                isButtonEnable:
                    selectedCategoriesSnapshot != null ? true : false,
                openNext: () {
                  registrationFase.value = InstanceBookingFaze.two;
                },
              ),
            ],
          );
        });
  }

  Widget faze2View({
    required BuildContext context,
  }) {
    return ValueListenableBuilder<Timing?>(
        valueListenable: selectedMeetingDuration,
        builder: (context, selectedDurationsSnapshot, child) {
          return Column(
            children: [
              const SizedBox(height: 20),
              CustomText(
                title: "-- ${AppLocalizations.of(context)!.meetingduration} --",
                textColor: const Color(0xff444444),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              BookingCell(
                title: "15 ${AppLocalizations.of(context)!.min}",
                isSelected: (selectedDurationsSnapshot ?? Timing.hour) ==
                    Timing.quarterHour,
                onPress: () {
                  selectedMeetingDuration.value = Timing.quarterHour;
                },
              ),
              BookingCell(
                title: "30 ${AppLocalizations.of(context)!.min}",
                isSelected: (selectedDurationsSnapshot ?? Timing.hour) ==
                    Timing.halfHour,
                onPress: () {
                  selectedMeetingDuration.value = Timing.halfHour;
                },
              ),
              BookingCell(
                title: "45 ${AppLocalizations.of(context)!.min}",
                isSelected: (selectedDurationsSnapshot ?? Timing.hour) ==
                    Timing.threeQuarter,
                onPress: () {
                  selectedMeetingDuration.value = Timing.threeQuarter;
                },
              ),
              BookingCell(
                title: "60 ${AppLocalizations.of(context)!.min}",
                isSelected:
                    (selectedDurationsSnapshot ?? Timing.hour) == Timing.hour,
                onPress: () {
                  selectedMeetingDuration.value = Timing.hour;
                },
              ),
              const SizedBox(height: 8),
              footerBottomSheet(
                context: context,
                duration: selectedDurationsSnapshot != null
                    ? "${ParserTimer().getTime(selectedDurationsSnapshot)} ${AppLocalizations.of(context)!.min}"
                    : "",
                isButtonEnable:
                    selectedDurationsSnapshot != null ? true : false,
                categoryName: selectedCategory.value!.name!,
                openNext: () {
                  registrationFase.value = InstanceBookingFaze.three;
                },
              )
            ],
          );
        });
  }

  Widget faze3View(
      {required BuildContext context,
      required Function(
              Category selectedCategory, Timing selectedMeetingDuration)
          onEndSelection}) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Center(
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
                color: const Color(0xffE4E9EF),
                borderRadius: BorderRadius.circular(50)),
            child: const Icon(
              Icons.security,
              color: Color(0xff444444),
              size: 75,
            ),
          ),
        ),
        const SizedBox(height: 20),
        CustomText(
          title: AppLocalizations.of(context)!.bookinglaststeptitle,
          textColor: const Color(0xff444444),
          fontSize: 14,
          maxLins: 3,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 20),
        PointsInLastViewBooking(
          number: "1",
          text: AppLocalizations.of(context)!.bookinglaststeptext1,
        ),
        const SizedBox(height: 20),
        PointsInLastViewBooking(
          number: "2",
          text: AppLocalizations.of(context)!.bookinglaststeptext2,
        ),
        const SizedBox(height: 20),
        PointsInLastViewBooking(
          number: "3",
          text: AppLocalizations.of(context)!.bookinglaststeptext3,
        ),
        const SizedBox(height: 20),
        PointsInLastViewBooking(
          number: "4",
          text: AppLocalizations.of(context)!.bookinglaststeptext4,
        ),
        const SizedBox(height: 20),
        footerBottomSheet(
          context: context,
          isButtonEnable: true,
          duration:
              "${ParserTimer().getTime(selectedMeetingDuration.value)} ${AppLocalizations.of(context)!.min}",
          categoryName: selectedCategory.value!.name!,
          openNext: () {
            onEndSelection(
                selectedCategory.value!, selectedMeetingDuration.value);
          },
        )
      ],
    );
  }

  Widget footerBottomSheet(
      {required BuildContext context,
      required bool isButtonEnable,
      required String categoryName,
      required String duration,
      required Function() openNext}) {
    return Column(
      children: [
        Container(height: 1, color: const Color(0xff444444)),
        Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomText(
                        title: "${AppLocalizations.of(context)!.category} :",
                        fontSize: 14,
                        maxLins: 2,
                        textColor: const Color(0xff554d56),
                      ),
                      const SizedBox(width: 2),
                      categoryName != ""
                          ? CustomText(
                              title: categoryName,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              textColor: const Color(0xff554d56),
                            )
                          : Container(),
                    ],
                  ),
                  Row(
                    children: [
                      CustomText(
                        title:
                            "${AppLocalizations.of(context)!.meetingduration} :",
                        fontSize: 14,
                        textColor: const Color(0xff554d56),
                      ),
                      const SizedBox(width: 2),
                      duration != ""
                          ? CustomText(
                              title: duration,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              textColor: const Color(0xff554d56),
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            SizedBox(
              height: 80,
              width: MediaQuery.of(context).size.width / 4,
              child: CustomButton(
                padding: const EdgeInsets.only(top: 8),
                enableButton: isButtonEnable,
                width: MediaQuery.of(context).size.width / 4,
                buttonTitle: AppLocalizations.of(context)!.next,
                onTap: () => openNext(),
              ),
            ),
          ],
        )
      ],
    );
  }

  String faseTitle(InstanceBookingFaze fase) {
    switch (fase) {
      case InstanceBookingFaze.one:
        return "1/3";
      case InstanceBookingFaze.two:
        return "2/3";
      case InstanceBookingFaze.three:
        return "3/3";
    }
  }

  Widget showCorrectViewDependOnFase(
      {required InstanceBookingFaze fase,
      required BuildContext context,
      required List<Category> listOfCategories,
      required Function(
              Category selectedCategory, Timing selectedMeetingDuration)
          onEndSelection}) {
    switch (fase) {
      case InstanceBookingFaze.one:
        return faze1View(context: context, listOfCategories: listOfCategories);
      case InstanceBookingFaze.two:
        return faze2View(context: context);
      case InstanceBookingFaze.three:
        return faze3View(
          context: context,
          onEndSelection: (category, time) {
            onEndSelection(category, time);
          },
        );
    }
  }
}
