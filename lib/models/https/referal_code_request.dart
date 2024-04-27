import 'package:legalz_hub_app/utils/mixins.dart';

class ReferalCodeRequest implements Model {
  ReferalCodeRequest({
    required this.code,
  });
  String code;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = code;
    return data;
  }
}
