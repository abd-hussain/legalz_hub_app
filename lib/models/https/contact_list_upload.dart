import 'package:legalz_hub_app/utils/mixins.dart';

class UploadContact implements Model {
  UploadContact({required this.list});
  List<MyContact> list;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['list'] = list.map((v) => v.toJson()).toList();
    return data;
  }
}

class MyContact {
  MyContact({this.fullName, this.mobileNumber, this.email, this.customersOwnerId, this.attorneyOwnerId});
  String? fullName;
  String? mobileNumber;
  String? email;
  int? customersOwnerId;
  int? attorneyOwnerId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['full_name'] = fullName ?? "";
    data['mobile_number'] = mobileNumber ?? "";
    data['email'] = email ?? "";
    data['customers_owner_id'] = customersOwnerId;
    data['attorney_owner_id'] = attorneyOwnerId;
    return data;
  }
}
