import 'package:legalz_hub_app/utils/mixins.dart';

class UploadContact implements Model {
  List<MyContact> list;

  UploadContact({required this.list});

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['list'] = list.map((v) => v.toJson()).toList();
    return data;
  }
}

class MyContact {
  String? fullName;
  String? mobileNumber;
  String? email;
  int? mentorownerid;

  MyContact({this.fullName, this.mobileNumber, this.email, this.mentorownerid});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['full_name'] = fullName ?? "";
    data['mobile_number'] = mobileNumber ?? "";
    data['email'] = email ?? "";
    data['mentor_owner_id'] = mentorownerid ?? 0;
    return data;
  }
}
