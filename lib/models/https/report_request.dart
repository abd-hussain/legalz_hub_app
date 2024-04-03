import 'dart:io';

import 'package:legalz_hub_app/utils/enums/user_type.dart';

class ReportRequest {
  String userId;
  UserType userType;
  String content;
  File? image1;
  File? image2;
  File? image3;

  ReportRequest({
    required this.userId,
    required this.content,
    required this.userType,
    this.image1,
    this.image2,
    this.image3,
  });
}
