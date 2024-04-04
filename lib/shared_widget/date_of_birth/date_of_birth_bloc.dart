import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateofBirthBloc {
  TextEditingController dobController = TextEditingController();

  format(DateTime datePicked) {
    dobController.text = DateFormat('dd/MM/yyyy').format(datePicked);
  }

  DateTime? parseDate(String date) {
    return DateFormat('dd/MM/yyyy').parse(date);
  }
}
