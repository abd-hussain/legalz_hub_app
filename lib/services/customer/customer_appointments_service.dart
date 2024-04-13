import 'package:legalz_hub_app/models/https/appointment_request.dart';
import 'package:legalz_hub_app/models/https/attorney_appoitments_response.dart';
import 'package:legalz_hub_app/models/https/customer_appointment.dart';
import 'package:legalz_hub_app/models/https/note_appointment_request.dart';
import 'package:legalz_hub_app/utils/mixins.dart';
import 'package:legalz_hub_app/utils/repository/http_repository.dart';
import 'package:legalz_hub_app/utils/repository/method_name_constractor.dart';

class CustomerAppointmentsService with Service {
  Future<AttorneyAppointmentsResponse> getAttorneyAppointments(
      int attorneyID) async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.specificAttorneyAppointments,
      queryParam: {"id": attorneyID},
    );

    return AttorneyAppointmentsResponse.fromJson(response);
  }

  Future<CustomerAppointment> getCustomerAppointments() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.customerAppointments,
    );
    return CustomerAppointment.fromJson(response);
  }

  Future<CustomerAppointment> getClientActiveAppointments() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.customerAppointmentsActive,
    );
    return CustomerAppointment.fromJson(response);
  }

  Future<dynamic> cancelAppointment({required int id}) async {
    final response = await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.customerAppointmentsCancel,
      queryParam: {"id": id},
    );

    return response;
  }

  Future<dynamic> customerJoinCall(
      {required int id, required String channelName}) async {
    final response = await repository.callRequest(
      requestType: RequestType.put,
      methodName: MethodNameConstant.customerAppointmentsJoinCall,
      queryParam: {"id": id, "channel_name": channelName},
    );

    return response;
  }

  Future<void> customerEndCall({required int id}) async {
    final response = await repository.callRequest(
      requestType: RequestType.put,
      methodName: MethodNameConstant.customerAppointmentsEndCall,
      queryParam: {"id": id},
    );

    return response;
  }

  Future<dynamic> editNoteAppointment(
      {required NoteAppointmentRequest noteAppointment}) async {
    final response = await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.customerAppointmentsEditNote,
      postBody: noteAppointment,
    );

    return response;
  }

  Future<dynamic> bookNewAppointments(
      {required AppointmentRequest appointment}) async {
    final response = await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.bookAppointment,
      postBody: appointment,
    );

    return response;
  }
}
