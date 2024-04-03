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
  int? customersOwnerId;
  int? attorneyOwnerId;

  MyContact(
      {this.fullName,
      this.mobileNumber,
      this.email,
      this.customersOwnerId,
      this.attorneyOwnerId});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['full_name'] = fullName ?? "";
    data['mobile_number'] = mobileNumber ?? "";
    data['email'] = email ?? "";
    data['customers_owner_id'] = customersOwnerId ?? 0;
    data['attorney_owner_id'] = attorneyOwnerId ?? 0;
    return data;
  }
}
