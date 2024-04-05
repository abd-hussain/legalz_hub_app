import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legalz_hub_app/models/https/categories_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/shared_widget/custom_textfield.dart';

class CategoryField extends StatelessWidget {
  final TextEditingController controller;
  final bool isEnable;
  final EdgeInsets padding;
  final List<Category> listOfCategory;
  final Function(Category) selectedCategory;
  const CategoryField(
      {required this.controller,
      this.padding = const EdgeInsets.only(left: 16, right: 16),
      required this.listOfCategory,
      required this.selectedCategory,
      this.isEnable = true,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomTextField(
          readOnly: true,
          enabled: isEnable,
          controller: controller,
          hintText: AppLocalizations.of(context)!.selectCategory,
          padding: padding,
          keyboardType: TextInputType.name,
          inputFormatters: [
            LengthLimitingTextInputFormatter(45),
          ],
        ),
        InkWell(
          onTap: isEnable
              ? () async {
                  await categoryBottomSheet(context, listOfCategory,
                      (categorySelected) {
                    controller.text = categorySelected.name!;
                    selectedCategory(categorySelected);
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

  Future categoryBottomSheet(BuildContext context,
      List<Category> listOfCategory, Function(Category) selectedCategory) {
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                title: AppLocalizations.of(context)!.selectCategory,
                textColor: Colors.black,
                fontSize: 20,
              ),
              const SizedBox(height: 27.0),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: listOfCategory.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        selectedCategory(listOfCategory[index]);
                      },
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            Image.network(
                              listOfCategory[index].icon!,
                              width: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CustomText(
                                title: listOfCategory[index].name!,
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
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
