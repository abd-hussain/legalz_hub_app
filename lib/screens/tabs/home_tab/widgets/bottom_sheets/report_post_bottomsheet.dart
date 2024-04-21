import 'package:flutter/material.dart';
import 'package:legalz_hub_app/shared_widget/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
//TODO: handle report post

class ReportPostBottomSheetsUtil {
  Future bottomSheet(
      {required BuildContext context, required List<String> reportTitles, required Function(String) reportAction}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        context: context,
        builder: (context) {
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
                      title: AppLocalizations.of(context)!.reportposttitle,
                      textColor: const Color(0xff444444),
                      textAlign: TextAlign.center,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: CustomButton(
                        enableButton: false, //validateFields(refreshPageSnapshot.data),
                        onTap: () {
                          Navigator.of(context).pop();
                          // reportAction(
                          //   reportTitle: refreshPageSnapshot.data!.categorySelected!.id!,
                          // );
                        }),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: reportTitles.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                        title: reportTitles[index],
                        textColor: const Color(0xff444444),
                        fontSize: 12,
                        maxLins: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        });
  }
}
