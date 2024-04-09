import 'package:flutter/material.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class MentorGridItem extends StatelessWidget {
  final String title;
  final String value;
  final Widget icon;

  const MentorGridItem(
      {required this.title,
      required this.value,
      required this.icon,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xffE4E9EF),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(child: icon),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: title,
              fontSize: 12,
              textColor: const Color(0xff554d56),
            ),
            const SizedBox(height: 8),
            CustomText(
              title: value,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              textColor: const Color(0xff444444),
            )
          ],
        )
      ],
    );
  }
}
