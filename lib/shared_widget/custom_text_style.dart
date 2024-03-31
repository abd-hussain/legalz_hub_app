import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStyle {
  CustomTextStyle? _instance;

  Future<CustomTextStyle> getInstance() async {
    _instance = CustomTextStyle();
    return _instance!;
  }

  TextStyle regular({Color? color, double? size}) {
    return GoogleFonts.questrial(
        textStyle: TextStyle(
      color: color,
      decoration: TextDecoration.none,
      fontSize: size,
      fontWeight: FontWeight.w400,
    ));
  }

  TextStyle medium({Color? color, double? size}) {
    return GoogleFonts.questrial(
      textStyle: TextStyle(
        color: color,
        decoration: TextDecoration.none,
        fontSize: size,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  TextStyle bold({Color? color, double? size}) {
    return GoogleFonts.questrial(
      textStyle: TextStyle(
        color: color,
        decoration: TextDecoration.none,
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  TextStyle semibold({Color? color, double? size}) {
    return GoogleFonts.questrial(
      textStyle: TextStyle(
        color: color,
        decoration: TextDecoration.none,
        fontSize: size,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
