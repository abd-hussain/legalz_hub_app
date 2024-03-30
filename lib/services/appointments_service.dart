import 'package:legalz_hub_app/models/https/active_appointment.dart';
import 'package:legalz_hub_app/models/https/add_comment_appointment.dart';
import 'package:legalz_hub_app/models/https/appointment.dart';
import 'package:legalz_hub_app/utils/mixins.dart';
import 'package:legalz_hub_app/utils/repository/http_repository.dart';
import 'package:legalz_hub_app/utils/repository/method_name_constractor.dart';

class AppointmentsService with Service {
  Future<Appointments> getMentorAppointments() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.mentorAppointments,
    );

    return Appointments.fromJson(response);
  }

  Future<ActiveAppointments> getActiveMentorAppointments() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.mentorActiveAppointments,
    );

    return ActiveAppointments.fromJson(response);
  }

  Future<void> cancelAppointment({required int id}) async {
    final response = await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.cancelAppointment,
      queryParam: {"id": id},
    );

    return response;
  }

  Future<dynamic> joinCall(
      {required int id, required String channelName}) async {
    final response = await repository.callRequest(
      requestType: RequestType.put,
      methodName: MethodNameConstant.joinCallAppointment,
      queryParam: {"id": id, "channel_name": channelName},
    );

    return response;
  }

  Future<void> exitCall({required int id}) async {
    final response = await repository.callRequest(
      requestType: RequestType.put,
      methodName: MethodNameConstant.exitCallAppointment,
      queryParam: {"id": id},
    );

    return response;
  }

  Future<void> addCommentToAppointment(
      {required AddCommentToAppointment body}) async {
    final response = await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.commentAppointment,
      postBody: body,
    );

    return response;
  }
}
