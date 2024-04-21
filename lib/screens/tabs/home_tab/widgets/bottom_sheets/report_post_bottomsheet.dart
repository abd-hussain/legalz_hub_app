import 'package:flutter/material.dart';
import 'package:legalz_hub_app/models/report_model.dart';
import 'package:legalz_hub_app/shared_widget/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
//TODO: handle report post other

class ReportPostBottomSheetsUtil {
  int selectedRadioTile = 0;
  ValueNotifier<ReportPostModel?> selectedReportNotifer =
      ValueNotifier<ReportPostModel?>(null);

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
                return Column(
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
                              enableButton: selectedReportNotifer.value != null
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
                            },
                            activeColor: Colors.red,
                            selected: selectedReportNotifer.value == snapshot,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24)
                  ],
                );
              });
        });
  }
}
