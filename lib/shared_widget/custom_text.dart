import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      required this.title,
      required this.fontSize,
      this.maxLins = 1,
      this.textOverflow = TextOverflow.ellipsis,
      this.textAlign = TextAlign.start,
      this.textColor = Colors.white,
      this.fontWeight = FontWeight.normal});
  final String title;
  final double fontSize;
  final Color textColor;
  final int maxLins;
  final TextOverflow textOverflow;
  final TextAlign textAlign;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: maxLins,
      overflow: textOverflow,
      textAlign: textAlign,
      style: GoogleFonts.questrial(
        fontSize: fontSize,
        color: textColor,
        fontWeight: fontWeight,
      ),
    );
  }
}
