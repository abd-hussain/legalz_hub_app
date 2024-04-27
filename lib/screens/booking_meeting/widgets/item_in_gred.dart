import 'package:flutter/material.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class ItemInGrid extends StatelessWidget {
  const ItemInGrid({
    super.key,
    required this.title,
    required this.value,
    this.valueHight = 25,
  });
  final String title;
  final String? value;
  final double valueHight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 25,
          color: Colors.grey[300],
          child: Center(
            child: CustomText(
              title: title,
              fontSize: 16,
              textColor: Colors.black,
            ),
          ),
        ),
        Container(
          height: valueHight,
          color: Colors.grey[400],
          child: Center(
            child: value != null
                ? CustomText(
                    title: value!,
                    fontSize: 16,
                    textColor: Colors.black,
                  )
                : const SizedBox(
                    height: 10,
                    width: 10,
                    child: CircularProgressIndicator(
                      color: Color(0xff034061),
                      strokeWidth: 3,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
