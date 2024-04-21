import 'package:flutter/material.dart';
import 'package:legalz_hub_app/locator.dart';
import 'package:legalz_hub_app/models/https/attorney_model.dart';
import 'package:legalz_hub_app/models/https/categories_model.dart';
import 'package:legalz_hub_app/screens/main_container/main_container_bloc.dart';
import 'package:legalz_hub_app/screens/tabs/category_tab/categories_bloc.dart';
import 'package:legalz_hub_app/screens/tabs/category_tab/widgets/list_categories_widget.dart';
import 'package:legalz_hub_app/screens/tabs/category_tab/widgets/main_view_widget.dart';
import 'package:legalz_hub_app/shared_widget/main_header_view.dart';
import 'package:legalz_hub_app/shared_widget/shimmers/shimmer_categories.dart';
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
      child: FutureBuilder<List<Category>>(
          initialData: const [],
          future: locator<MainContainerBloc>().getlistOfCategories(context),
          builder: (context, snapshotCategory) {
            if (snapshotCategory.hasData) {
              _bloc.setupScreen(snapshotCategory.data![1]);

              return Column(
                children: [
                  MainHeaderView(
                    userType: UserType.customer,
                    refreshCallBack: () {
                      locator<MainContainerBloc>().getlistOfCategories(context);
                    },
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        CategoriesList(
                          categoriesList: snapshotCategory.data!,
                          onTap: (category) {
                            _bloc.selectedCategoryNotifier.value = category;
                            _bloc.attorniesListNotifier.value = null;
                            _bloc.listOfMentors(categoryID: category.id!);
                          },
                        ),
                        ValueListenableBuilder<Category?>(
                            valueListenable: _bloc.selectedCategoryNotifier,
                            builder: (context, snapshot, chuld) {
                              if (snapshot != null) {
                                return ValueListenableBuilder<
                                        List<AttorneyModelData>?>(
                                    valueListenable:
                                        _bloc.attorniesListNotifier,
                                    builder: (context, snapshot2, child) {
                                      return CategoryMainView(
                                        selectedCategory: snapshot,
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
              );
            } else {
              return const ShimmerCategoriesView();
            }
          }),
    );
  }
}
