import 'package:flutter/material.dart';

class MainContext {
  BuildContext? mainContext;
  String? screenName;

  void setMainContext(BuildContext? context) {
    mainContext = context;
  }
}
