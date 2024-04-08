import 'package:flutter/material.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';

PreferredSizeWidget customAppBar(
    {required String title,
    required UserType userType,
    List<Widget>? actions}) {
  return AppBar(
    backgroundColor: userType == UserType.customer
        ? const Color(0xff034061)
        : const Color(0xff292929),
    iconTheme: const IconThemeData(color: Colors.white),
    title: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          title: title,
          fontSize: 14,
          textColor: Colors.white,
        )
      ],
    ),
    actions: actions,
  );
}
