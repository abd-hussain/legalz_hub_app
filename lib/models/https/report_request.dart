import 'dart:io';

import 'package:legalz_hub_app/utils/enums/user_type.dart';

class ReportRequest {
  ReportRequest({
    required this.userId,
    required this.content,
    required this.userType,
    this.attach1,
    this.attach2,
    this.attach3,
  });
  String userId;
  UserType userType;
  String content;
  File? attach1;
  File? attach2;
  File? attach3;
}
