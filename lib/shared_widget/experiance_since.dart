import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/shared_widget/custom_textfield.dart';

class ExperianceSinceField extends StatefulWidget {
  const ExperianceSinceField(
      {required this.controller,
      this.padding = const EdgeInsets.only(left: 16, right: 16),
      this.isEnable = true,
      required this.onSelected,
      super.key});
  final TextEditingController controller;
  final bool isEnable;
  final EdgeInsets padding;
  final VoidCallback onSelected;

  @override
  State<ExperianceSinceField> createState() => _ExperianceSinceFieldState();
}

class _ExperianceSinceFieldState extends State<ExperianceSinceField> {
  @override
  void initState() {
    widget.controller.addListener(() {
      widget.onSelected();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomTextField(
          readOnly: true,
          enabled: widget.isEnable,
          controller: widget.controller,
          hintText: AppLocalizations.of(context)!.experience_since,
          padding: widget.padding,
          keyboardType: TextInputType.name,
          inputFormatters: [
            LengthLimitingTextInputFormatter(45),
          ],
        ),
        InkWell(
          onTap: widget.isEnable
              ? () async {
                  await experianceSinceBottomSheet(context, (selected) {
                    widget.controller.text = selected;
                  });
                }
              : null,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 16),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 55,
            ),
          ),
        ),
      ],
    );
  }

  Future experianceSinceBottomSheet(
      BuildContext context, Function(String) selectedYear) {
    final int currentYear = DateTime.now().year;
    final List<String> listOfYears = [];
    for (int x = currentYear; x > currentYear - 50; x--) {
      listOfYears.add(x.toString());
    }

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
                title: AppLocalizations.of(context)!.experience_since,
                textColor: Colors.black,
                fontSize: 20,
              ),
              const SizedBox(height: 27),
              SizedBox(
                height: 200,
                child: ListView.builder(
                    itemCount: listOfYears.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          selectedYear(listOfYears[index]);
                        },
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomText(
                                  title: listOfYears[index],
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
}
