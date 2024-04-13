import 'package:flutter/material.dart';

class MainLogo extends StatelessWidget {
  const MainLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/logoz/logo-blue.png",
      alignment: Alignment.center,
      height: 100,
    );
  }
}
