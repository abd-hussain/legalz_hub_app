import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class TutView extends StatelessWidget {
  final String title;
  final String desc;

  final String image;

  const TutView({
    super.key,
    required this.title,
    required this.desc,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Image.asset(
              "assets/images/logoz/logo-black.png",
              height: 150,
              width: 175,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: CustomText(
                title: title,
                fontSize: 24,
                textAlign: TextAlign.center,
                maxLins: 4,
                fontWeight: FontWeight.bold,
                textColor: const Color(0xff444444),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
              child: CustomText(
                title: desc,
                fontSize: 18,
                textAlign: TextAlign.center,
                maxLins: 4,
                fontWeight: FontWeight.bold,
                textColor: const Color(0xff444444),
              ),
            ),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    (MediaQuery.of(context).size.width - 16) / 2),
                child: Image.asset(
                  image,
                  height: kIsWeb ? 300 : MediaQuery.of(context).size.width - 64,
                  width: kIsWeb ? 300 : MediaQuery.of(context).size.width - 64,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
