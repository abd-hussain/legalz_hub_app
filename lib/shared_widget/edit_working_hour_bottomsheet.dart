import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/models/working_hours.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class EditWorkingHourBottomSheetsUtil {
  Future workingHour(
      {required BuildContext context,
      required String dayname,
      required List<CheckBox> listOfWorkingHour,
      required Function(List<int>) onSave}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        context: context,
        builder: (context) {
          return EditWorkingHoursView(
            dayName: dayname,
            listOfWorkingHour: listOfWorkingHour,
            onSave: (p0) => onSave(p0),
          );
        });
  }
}

class EditWorkingHoursView extends StatefulWidget {
  const EditWorkingHoursView(
      {super.key,
      required this.dayName,
      required this.listOfWorkingHour,
      required this.onSave});
  final String dayName;
  final List<CheckBox> listOfWorkingHour;
  final Function(List<int>) onSave;

  @override
  State<EditWorkingHoursView> createState() => _EditWorkingHoursViewState();
}

class _EditWorkingHoursViewState extends State<EditWorkingHoursView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
              Column(
                children: [
                  CustomText(
                    title: AppLocalizations.of(context)!.editworkingHour,
                    textColor: Colors.black,
                    fontSize: 18,
                  ),
                  CustomText(
                    title: widget.dayName,
                    textColor: Colors.black,
                    fontSize: 18,
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: InkWell(
                  onTap: () {
                    final List<int> listOfSelectedHour = [];

                    for (final CheckBox item in widget.listOfWorkingHour) {
                      if (item.isEnable) {
                        listOfSelectedHour
                            .add(convertHourStringToInt(item.value));
                      }
                    }

                    widget.onSave(listOfSelectedHour);
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
          SizedBox(
            height: 500,
            child: ListView.builder(
                itemCount: widget.listOfWorkingHour.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        title: widget.listOfWorkingHour[index].value,
                        textColor: Colors.black,
                        fontSize: 18,
                      ),
                      Checkbox(
                          value: widget.listOfWorkingHour[index].isEnable,
                          onChanged: (va) {
                            widget.listOfWorkingHour[index].isEnable =
                                !widget.listOfWorkingHour[index].isEnable;
                            setState(() {});
                          }),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }

  int convertHourStringToInt(String value) {
    if (value == "1:00 ${AppLocalizations.of(context)!.pm}") {
      return 1;
    } else if (value == "2:00 ${AppLocalizations.of(context)!.pm}") {
      return 2;
    } else if (value == "3:00 ${AppLocalizations.of(context)!.pm}") {
      return 3;
    } else if (value == "4:00 ${AppLocalizations.of(context)!.pm}") {
      return 4;
    } else if (value == "5:00 ${AppLocalizations.of(context)!.pm}") {
      return 5;
    } else if (value == "6:00 ${AppLocalizations.of(context)!.pm}") {
      return 6;
    } else if (value == "7:00 ${AppLocalizations.of(context)!.pm}") {
      return 7;
    } else if (value == "8:00 ${AppLocalizations.of(context)!.pm}") {
      return 8;
    } else if (value == "9:00 ${AppLocalizations.of(context)!.pm}") {
      return 9;
    } else if (value == "10:00 ${AppLocalizations.of(context)!.pm}") {
      return 10;
    } else if (value == "11:00 ${AppLocalizations.of(context)!.pm}") {
      return 11;
    } else if (value == "12:00 ${AppLocalizations.of(context)!.pm}") {
      return 12;
    } else if (value == "1:00 ${AppLocalizations.of(context)!.am}") {
      return 13;
    } else if (value == "2:00 ${AppLocalizations.of(context)!.am}") {
      return 14;
    } else if (value == "3:00 ${AppLocalizations.of(context)!.am}") {
      return 15;
    } else if (value == "4:00 ${AppLocalizations.of(context)!.am}") {
      return 16;
    } else if (value == "5:00 ${AppLocalizations.of(context)!.am}") {
      return 17;
    } else if (value == "6:00 ${AppLocalizations.of(context)!.am}") {
      return 18;
    } else if (value == "7:00 ${AppLocalizations.of(context)!.am}") {
      return 19;
    } else if (value == "8:00 ${AppLocalizations.of(context)!.am}") {
      return 20;
    } else if (value == "9:00 ${AppLocalizations.of(context)!.am}") {
      return 21;
    } else if (value == "10:00 ${AppLocalizations.of(context)!.am}") {
      return 22;
    } else if (value == "11:00 ${AppLocalizations.of(context)!.am}") {
      return 23;
    } else {
      return 0;
    }
  }
}
