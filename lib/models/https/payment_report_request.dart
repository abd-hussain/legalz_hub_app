import 'package:legalz_hub_app/utils/mixins.dart';

class PaymentReportRequest implements Model {
  int paymentId;
  String message;

  PaymentReportRequest({
    required this.paymentId,
    required this.message,
  });

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['payment_id'] = paymentId;
    data['message'] = message;
    return data;
  }
}
