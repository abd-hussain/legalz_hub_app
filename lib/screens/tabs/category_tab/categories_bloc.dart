import 'package:flutter/material.dart';
import 'package:legalz_hub_app/locator.dart';
import 'package:legalz_hub_app/models/https/attorney_model.dart';
import 'package:legalz_hub_app/models/https/categories_model.dart';
import 'package:legalz_hub_app/services/customer/attorney_list_service.dart';
import 'package:legalz_hub_app/services/filter_services.dart';
import 'package:legalz_hub_app/utils/mixins.dart';

class CategoriesBloc extends Bloc<FilterService> {
  final ValueNotifier<List<Category>> categoriesListNotifier =
      ValueNotifier<List<Category>>([]);
  final ValueNotifier<Category?> selectedCategoryNotifier =
      ValueNotifier<Category?>(null);
  final ValueNotifier<List<AttorneyModelData>?> attorniesListNotifier =
      ValueNotifier<List<AttorneyModelData>?>(null);

  void listOfCategories() {
    service.categories().then((value) {
      categoriesListNotifier.value = value.data!
        ..sort((a, b) => a.id!.compareTo(b.id!));
      selectedCategoryNotifier.value = categoriesListNotifier.value[0];
      listOfMentors(categoryID: categoriesListNotifier.value[0].id!);
    });
  }

  void listOfMentors({required int categoryID}) {
    locator<AttorneyListService>()
        .attorneyUnderCategory(categoryID)
        .then((value) {
      if (value.data != null) {
        attorniesListNotifier.value = value.data!
          ..sort((a, b) => a.id!.compareTo(b.id!));
      } else {
        attorniesListNotifier.value = [];
      }
    });
  }

  @override
  onDispose() {
    categoriesListNotifier.dispose();
    selectedCategoryNotifier.dispose();
    attorniesListNotifier.dispose();
  }
}
