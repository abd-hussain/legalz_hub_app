import 'package:legalz_hub_app/models/https/add_comment_appointment.dart';
import 'package:legalz_hub_app/models/https/attorney_appointment.dart';
import 'package:legalz_hub_app/utils/mixins.dart';
import 'package:legalz_hub_app/utils/repository/http_repository.dart';
import 'package:legalz_hub_app/utils/repository/method_name_constractor.dart';

class AttorneyAppointmentsService with Service {
  Future<AttorneyAppointments> getAttorneyAppointments() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.attorneyAppointments,
    );

    return AttorneyAppointments.fromJson(response);
  }

  Future<AttorneyAppointments> getActiveAttorneyAppointments() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.attorneyActiveAppointments,
    );

    return AttorneyAppointments.fromJson(response);
  }

  Future<void> attorneyCancelAppointment({required int id}) async {
    final response = await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.attorneyCancelAppointment,
      queryParam: {"id": id},
    );

    return response;
  }

  Future<dynamic> attorneyJoinCall(
      {required int id, required String channelName}) async {
    final response = await repository.callRequest(
      requestType: RequestType.put,
      methodName: MethodNameConstant.attorneyJoinCallAppointment,
      queryParam: {"id": id, "channel_name": channelName},
    );

    return response;
  }

  Future<void> attorneyEndCall({required int id}) async {
    final response = await repository.callRequest(
      requestType: RequestType.put,
      methodName: MethodNameConstant.attorneyEndCallAppointment,
      queryParam: {"id": id},
    );

    return response;
  }

  Future<void> attorneyAddCommentToAppointment(
      {required AddCommentToAppointment body}) async {
    final response = await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.attorneyCommentAppointment,
      postBody: body,
    );

    return response;
  }
}
