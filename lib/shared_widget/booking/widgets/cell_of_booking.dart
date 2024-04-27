import 'package:flutter/material.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class BookingCell extends StatelessWidget {
  const BookingCell(
      {required this.title,
      required this.isSelected,
      required this.onPress,
      super.key});
  final String title;
  final bool isSelected;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap: onPress,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: isSelected
                    ? const Color(0xff034061)
                    : const Color(0xffE4E9EF),
                width: 3),
            color: const Color(0xffE4E9EF),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: CustomText(
                title: title,
                textColor: const Color(0xff444444),
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
                fontSize: 11,
                maxLins: 4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
