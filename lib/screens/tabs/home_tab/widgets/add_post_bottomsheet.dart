import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/models/https/categories_model.dart';
import 'package:legalz_hub_app/shared_widget/bio_field.dart';
import 'package:legalz_hub_app/shared_widget/booking/widgets/cell_of_booking.dart';
import 'package:legalz_hub_app/shared_widget/custom_button.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

//TODO keyboard problem
//TODO category design and space
//TODO: validate button before submit
class AddPostBottomSheetsUtil {
  ValueNotifier<Category?> selectedCategory = ValueNotifier<Category?>(null);

  TextEditingController textController = TextEditingController();

  Future bottomSheet(
      {required BuildContext context,
      required List<Category> categories,
      required Function({required int catId, required String content, String? postImg}) addPost}) {
    List<Category> listOfCategories = categories.where((s) => s.id != 0).toList();

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
            padding: const EdgeInsets.all(18.0),
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
                        title: AppLocalizations.of(context)!.addnewquestion,
                        textColor: const Color(0xff444444),
                        textAlign: TextAlign.center,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: CustomButton(
                          enableButton: true,
                          onTap: () {
                            Navigator.of(context).pop();
                          }),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: AppLocalizations.of(context)!.tipsfornewquestiontitle,
                            textColor: const Color(0xff444444),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            maxLins: 2,
                          ),
                          CustomText(
                            title: "- ${AppLocalizations.of(context)!.tipsfornewquestion1}",
                            textColor: const Color(0xff444444),
                            fontSize: 11,
                            maxLins: 2,
                          ),
                          CustomText(
                            title: "- ${AppLocalizations.of(context)!.tipsfornewquestion2}",
                            textColor: const Color(0xff444444),
                            fontSize: 11,
                            maxLins: 2,
                          ),
                          CustomText(
                            title: "- ${AppLocalizations.of(context)!.tipsfornewquestion3}",
                            textColor: const Color(0xff444444),
                            maxLins: 2,
                            fontSize: 11,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          "assets/images/avatar.jpeg",
                          width: 30,
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down_sharp),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          border: Border.all(
                            color: Color(0xFFEEEEEE),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomText(
                            title: "Select category",
                            textColor: const Color(0xff444444),
                            maxLins: 2,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ValueListenableBuilder<Category?>(
                //     valueListenable: selectedCategory,
                //     builder: (context, selectedCategoriesSnapshot, child) {
                //       return SizedBox(
                //         child: GridView.builder(
                //             shrinkWrap: true,
                //             physics: const NeverScrollableScrollPhysics(),
                //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //               crossAxisCount: 5,
                //               mainAxisSpacing: 0,
                //               crossAxisSpacing: 0,
                //               childAspectRatio: 1,
                //             ),
                //             itemCount: listOfCategories.length,
                //             itemBuilder: (context, index) {
                //               return BookingCell(
                //                 title: listOfCategories[index].name!,
                //                 isSelected: selectedCategoriesSnapshot != null
                //                     ? selectedCategoriesSnapshot == listOfCategories[index]
                //                     : false,
                //                 onPress: () {
                //                   selectedCategory.value = listOfCategories[index];
                //                 },
                //               );
                //             }),
                //       );
                //     }),
                Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: BioField(
                    bioController: textController,
                    title: AppLocalizations.of(context)!.whatdoyouwanttoask,
                    onChanged: (text) => validateFields(),
                  ),
                ),
              ],
            ),
          );
        });
  }

  validateFields() {}
}
