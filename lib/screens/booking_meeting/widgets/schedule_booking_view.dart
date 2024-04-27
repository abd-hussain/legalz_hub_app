import 'package:flutter/material.dart';
import 'package:legalz_hub_app/shared_widget/other_user_info_view.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';

class ScheduleBookingView extends StatelessWidget {
  const ScheduleBookingView(
      {super.key,
      required this.profileImg,
      required this.flagImage,
      required this.suffixName,
      required this.firstName,
      required this.lastName,
      required this.categoryName,
      required this.gender});
  final String? profileImg;
  final String? flagImage;
  final String? suffixName;
  final String? firstName;
  final String? lastName;
  final String? categoryName;
  final String? gender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: OtherUserInfoView(
        profileImg: profileImg,
        flagImage: flagImage,
        gender: gender,
        firstName: firstName,
        lastName: lastName,
        suffixName: suffixName,
        categoryName: categoryName,
        dateOfBirth: "",
        userType: UserType.attorney,
      ),
    );
  }
}
