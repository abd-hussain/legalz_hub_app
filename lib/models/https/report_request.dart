import 'dart:io';

class ReportRequest {
  String userId;
  String content;
  File? image1;
  File? image2;
  File? image3;

  ReportRequest({
    required this.userId,
    required this.content,
    this.image1,
    this.image2,
    this.image3,
  });
}
