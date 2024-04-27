import 'package:flutter/material.dart';

enum AccountButtonType {
  aboutUs,
  inviteFriends,
  reportSuggestion,
  reportProblem,
  notificationSetting,
  country,
  language,
  tutorials,
  shakeSetting,
  logout,
  loyality
}

class ProfileOptions {
  ProfileOptions(
      {required this.icon,
      this.iconColor = const Color(0xff034061),
      required this.name,
      this.nameColor = const Color(0xff034061),
      this.selectedItem = "",
      this.selectedItemImage,
      this.subtitle = "",
      this.avaliable = true,
      required this.onTap});
  final IconData icon;
  final Color iconColor;
  final String name;
  final Color nameColor;
  final String selectedItem;
  final Widget? selectedItemImage;
  final String subtitle;
  final bool avaliable;
  final VoidCallback onTap;
}
