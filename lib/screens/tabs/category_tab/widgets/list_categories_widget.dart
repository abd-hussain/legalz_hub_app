import 'package:flutter/material.dart';
import 'package:legalz_hub_app/models/https/categories_model.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList(
      {super.key, required this.categoriesList, required this.onTap});
  final List<Category> categoriesList;
  final Function(Category) onTap;

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: ListView.builder(
          itemCount: widget.categoriesList.length - 1,
          itemBuilder: (ctx, index) {
            return categoriesTile(
                context, widget.categoriesList[index + 1], index);
          }),
    );
  }

  Widget categoriesTile(BuildContext context, Category item, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4, bottom: 8),
      child: InkWell(
        onTap: () {
          selectedIndex.value = index;
          widget.onTap(item);
        },
        child: ValueListenableBuilder<int>(
            valueListenable: selectedIndex,
            builder: (context, snapshot, child) {
              return Container(
                height: 110,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      width: 3,
                      color: snapshot == index
                          ? const Color(0xff4CB6EA)
                          : Colors.white),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: FadeInImage(
                          placeholder: const AssetImage(
                              "assets/images/flagPlaceHolderImg.png"),
                          image: NetworkImage(item.icon!),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: CustomText(
                          title: item.name!,
                          fontSize: 14,
                          textAlign: TextAlign.center,
                          textColor: const Color(0xff034061),
                          maxLins: 4,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
