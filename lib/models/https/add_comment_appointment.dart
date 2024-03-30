import 'package:legalz_hub_app/utils/mixins.dart';

class AddCommentToAppointment implements Model {
  int id;
  String comment;

  AddCommentToAppointment({
    required this.id,
    required this.comment,
  });

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['id'] = id;
    data['comment'] = comment;
    return data;
  }
}
