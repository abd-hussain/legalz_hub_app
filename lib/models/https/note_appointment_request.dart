import 'package:legalz_hub_app/utils/mixins.dart';

class NoteAppointmentRequest implements Model {
  NoteAppointmentRequest({
    required this.id,
    required this.comment,
  });
  int id;
  String comment;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['comment'] = comment;
    return data;
  }
}
