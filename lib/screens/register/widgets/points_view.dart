import 'package:flutter/material.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class PointsViewBooking extends StatelessWidget {
  const PointsViewBooking(
      {required this.number,
      required this.text,
      super.key,
      this.textColor = const Color(0xff444444),
      required this.onPress});
  final String number;
  final String text;
  final Color textColor;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: const Color(0xffE4E9EF),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: CustomText(
              title: number,
              textColor: textColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CustomText(
            title: text,
            textColor: textColor,
            fontSize: 14,
            maxLins: 4,
          ),
        ),
        if (textColor != const Color(0xff444444))
          IconButton(
              onPressed: onPress,
              icon: Icon(
                Icons.arrow_circle_right,
                color: textColor,
              ))
        else
          const SizedBox(
            width: 20,
            height: 20,
          )
      ],
    );
  }
}
