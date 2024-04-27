import 'package:legalz_hub_app/utils/mixins.dart';

class PaymentReportRequest implements Model {
  PaymentReportRequest({
    required this.paymentId,
    required this.message,
  });
  int paymentId;
  String message;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['payment_id'] = paymentId;
    data['message'] = message;
    return data;
  }
}
