import 'dart:io';

import 'package:legalz_hub_app/models/https/categories_model.dart';

class AddPostModel {
  AddPostModel(
      {required this.categorySelected,
      required this.content,
      required this.attachment});
  Category? categorySelected;
  String? content;
  File? attachment;
}
