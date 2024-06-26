import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/models/https/categories_model.dart';
import 'package:legalz_hub_app/shared_widget/booking/widgets/cell_of_booking.dart';
import 'package:legalz_hub_app/shared_widget/custom_button.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class AddPostCategoryBottomSheetsUtil {
  ValueNotifier<Category?> selectedCategory = ValueNotifier<Category?>(null);

  Future bottomSheet(
      {required BuildContext context,
      required List<Category> listOfCategories,
      required Function(Category) selectedCategoryCallBack}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        context: context,
        builder: (context) {
          return ValueListenableBuilder<Category?>(
              valueListenable: selectedCategory,
              builder: (context, selectedCategoriesSnapshot, child) {
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
                            title: AppLocalizations.of(context)!.selectCategory,
                            textColor: const Color(0xff444444),
                            textAlign: TextAlign.center,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: CustomButton(
                              enableButton: selectedCategoriesSnapshot == null
                                  ? false
                                  : true,
                              buttonTitle:
                                  AppLocalizations.of(context)!.confirm,
                              onTap: () {
                                selectedCategoryCallBack(
                                    selectedCategoriesSnapshot!);
                                Navigator.of(context).pop();
                              }),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                          ),
                          itemCount: listOfCategories.length,
                          itemBuilder: (context, index) {
                            return BookingCell(
                              title: listOfCategories[index].name!,
                              isSelected: selectedCategoriesSnapshot != null
                                  ? selectedCategoriesSnapshot ==
                                      listOfCategories[index]
                                  : false,
                              onPress: () {
                                selectedCategory.value =
                                    listOfCategories[index];
                              },
                            );
                          }),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              });
        });
  }
}
