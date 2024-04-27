import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/models/https/categories_model.dart';
import 'package:legalz_hub_app/models/working_hours.dart';
import 'package:legalz_hub_app/services/filter_services.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/loading_status.dart';
import 'package:legalz_hub_app/utils/mixins.dart';

class AttorneyRegister2Bloc extends Bloc<FilterService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  TextEditingController bioController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController experianceSinceController = TextEditingController();

  File? cv;
  File? cert1;
  File? cert2;
  File? cert3;

  Category? selectedCategory;

  ValueNotifier<bool> enableNextBtn = ValueNotifier<bool>(false);
  ValueNotifier<List<Category>> listOfCategories =
      ValueNotifier<List<Category>>([]);
  StreamController<LoadingStatus> loadingStatusController =
      StreamController<LoadingStatus>();
  ValueNotifier<List<CheckBox>> listOfSpeakingLanguageNotifier =
      ValueNotifier<List<CheckBox>>([]);

  void tryToFillTheFields() {
    if (box.get(TempFieldToRegistrtAttorneyConstant.bio) != null) {
      bioController.text = box.get(TempFieldToRegistrtAttorneyConstant.bio);
    }

    if (box.get(TempFieldToRegistrtAttorneyConstant.experianceSince) != null) {
      experianceSinceController.text =
          box.get(TempFieldToRegistrtAttorneyConstant.experianceSince);
    }

    if (box.get(TempFieldToRegistrtAttorneyConstant.category) != null) {
      final id =
          int.parse(box.get(TempFieldToRegistrtAttorneyConstant.category));
      selectedCategory = Category(
        id: id,
        name: listOfCategories.value
            .firstWhere((element) => element.id == id)
            .name,
        icon: listOfCategories.value
            .firstWhere((element) => element.id == id)
            .icon,
      );

      categoryController.text = listOfCategories.value
              .firstWhere((element) => element.id == id)
              .name ??
          "";
    }

    if (box.get(TempFieldToRegistrtAttorneyConstant.speakingLanguages) !=
        null) {
      final originalList = _prepareList();

      for (final item in originalList) {
        for (final lang
            in box.get(TempFieldToRegistrtAttorneyConstant.speakingLanguages)) {
          if (item.value == lang) {
            item.isEnable = true;
          }
        }
      }

      listOfSpeakingLanguageNotifier.value = originalList;
    }

    loadingStatusController.sink.add(LoadingStatus.finish);
  }

  void validateFieldsForFaze2() {
    enableNextBtn.value = false;
    if (bioController.text.isNotEmpty &&
        categoryController.text.isNotEmpty &&
        experianceSinceController.text.isNotEmpty &&
        cv != null &&
        cert1 != null &&
        listOfSpeakingLanguageNotifier.value.isNotEmpty) {
      enableNextBtn.value = true;
    }
  }

  void getlistOfCategories() {
    loadingStatusController.sink.add(LoadingStatus.inprogress);

    service.categories().then((value) {
      listOfCategories.value = value.data!
        ..sort((a, b) => a.id!.compareTo(b.id!));
      listOfSpeakingLanguageNotifier.value = _prepareList();

      tryToFillTheFields();
    });
  }

  List<String> filterListOfSelectedLanguage(List<CheckBox> list) {
    final List<String> newList = [];
    for (final item in list) {
      if (item.isEnable) {
        newList.add(item.value);
      }
    }

    return newList;
  }

  List<CheckBox> _prepareList() {
    final List<CheckBox> list = [];

    list.add(CheckBox(value: "English", isEnable: false));
    list.add(CheckBox(value: "العربية", isEnable: true));
    list.add(CheckBox(value: "Français", isEnable: false));
    list.add(CheckBox(value: "Español", isEnable: false));
    list.add(CheckBox(value: "Türkçe", isEnable: false));

    return list;
  }

  @override
  void onDispose() {}
}
