import 'package:flutter/material.dart';

class MainContext {
  BuildContext? mainContext;

  void setMainContext(BuildContext? context) {
    mainContext = context;
  }
}
