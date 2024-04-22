import 'package:flutter/material.dart';
import 'package:legalz_hub_app/models/report_model.dart';
import 'package:legalz_hub_app/shared_widget/bio_field.dart';
import 'package:legalz_hub_app/shared_widget/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class ReportPostBottomSheetsUtil {
  ValueNotifier<ReportPostModel?> selectedReportNotifer =
      ValueNotifier<ReportPostModel?>(null);
  TextEditingController textController = TextEditingController();
  ValueNotifier<bool> otherOptionNotifer = ValueNotifier<bool>(false);

  Future bottomSheet(
      {required BuildContext context,
      required List<ReportPostModel> reporsList,
      required Function(ReportPostModel) reportAction}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        context: context,
        builder: (context) {
          return ValueListenableBuilder<ReportPostModel?>(
              valueListenable: selectedReportNotifer,
              builder: (context, snapshot, child) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(Icons.close),
                            ),
                          ),
                          Expanded(
                            child: CustomText(
                              title:
                                  AppLocalizations.of(context)!.reportposttitle,
                              textColor: const Color(0xff444444),
                              textAlign: TextAlign.center,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: CustomButton(
                                enableButton:
                                    selectedReportNotifer.value != null
                                        ? true
                                        : false,
                                onTap: () {
                                  Navigator.of(context).pop();
                                  reportAction(selectedReportNotifer.value!);
                                }),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: reporsList.length,
                          itemBuilder: (context, index) {
                            return RadioListTile(
                              value: snapshot,
                              groupValue: reporsList[index],
                              title: CustomText(
                                title: reporsList[index].title,
                                textColor: const Color(0xff444444),
                                fontSize: 12,
                                maxLins: 1,
                                fontWeight: FontWeight.bold,
                              ),
                              subtitle: CustomText(
                                title: reporsList[index].desc,
                                textColor: const Color(0xff444444),
                                fontSize: 12,
                                maxLins: 2,
                              ),
                              onChanged: (val) {
                                selectedReportNotifer.value = reporsList[index];
                                if (index == reporsList.length - 1) {
                                  otherOptionNotifer.value = true;
                                } else {
                                  otherOptionNotifer.value = false;
                                }
                              },
                              activeColor: Colors.red,
                              selected: selectedReportNotifer.value == snapshot,
                            );
                          },
                        ),
                      ),
                      ValueListenableBuilder<bool>(
                          valueListenable: otherOptionNotifer,
                          builder: (context, snapshot, child) {
                            if (snapshot) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: BioField(
                                  bioController: textController,
                                  title: AppLocalizations.of(context)!
                                      .whatdoyouwanttoask,
                                  onChanged: (text) {
                                    reporsList[reporsList.length - 1]
                                        .otherNote = text;
                                    selectedReportNotifer.value =
                                        reporsList[reporsList.length - 1];
                                  },
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                      const SizedBox(height: 24)
                    ],
                  ),
                );
              });
        });
  }
}
