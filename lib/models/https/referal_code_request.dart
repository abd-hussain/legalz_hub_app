import 'package:legalz_hub_app/utils/mixins.dart';

class ReferalCodeRequest implements Model {
  String code;

  ReferalCodeRequest({
    required this.code,
  });

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['code'] = code;
    return data;
  }
}
