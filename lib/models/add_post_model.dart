import 'dart:io';

import 'https/categories_model.dart';

class AddPostModel {
  Category? categorySelected;
  String? content;
  File? attachment;

  AddPostModel(
      {required this.categorySelected,
      required this.content,
      required this.attachment});
}
