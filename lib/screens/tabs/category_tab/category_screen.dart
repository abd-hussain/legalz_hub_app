import 'package:flutter/material.dart';
import 'package:legalz_hub_app/models/https/attorney_model.dart';
import 'package:legalz_hub_app/models/https/categories_model.dart';
import 'package:legalz_hub_app/screens/tabs/category_tab/categories_bloc.dart';
import 'package:legalz_hub_app/screens/tabs/category_tab/widgets/list_categories_widget.dart';
import 'package:legalz_hub_app/screens/tabs/category_tab/widgets/main_view_widget.dart';
import 'package:legalz_hub_app/shared_widget/main_header_view.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/logger.dart';

class CategoryTabScreen extends StatefulWidget {
  const CategoryTabScreen({super.key});

  @override
  State<CategoryTabScreen> createState() => _CategoryTabScreenState();
}

class _CategoryTabScreenState extends State<CategoryTabScreen> {
  final _bloc = CategoriesBloc();

  @override
  void didChangeDependencies() {
    logDebugMessage(message: 'Categories init Called ...');
    _bloc.listOfCategories();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          MainHeaderView(
            userType: UserType.customer,
            refreshCallBack: () {
              _bloc.listOfCategories();
            },
          ),
          Expanded(
            child: Row(
              children: [
                CategoriesList(
                  categoriesListNotifier: _bloc.categoriesListNotifier,
                  onTap: (category) {
                    _bloc.selectedCategoryNotifier.value = category;
                    _bloc.attorniesListNotifier.value = null;
                    _bloc.listOfMentors(categoryID: category.id!);
                  },
                ),
                ValueListenableBuilder<Category?>(
                    valueListenable: _bloc.selectedCategoryNotifier,
                    builder: (context, snapshot1, chuld) {
                      if (snapshot1 != null) {
                        return ValueListenableBuilder<List<AttorneyModelData>?>(
                            valueListenable: _bloc.attorniesListNotifier,
                            builder: (context, snapshot2, child) {
                              return CategoryMainView(
                                selectedCategory: snapshot1,
                                attorneyListNotifier: snapshot2,
                              );
                            });
                      } else {
                        return Container();
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
