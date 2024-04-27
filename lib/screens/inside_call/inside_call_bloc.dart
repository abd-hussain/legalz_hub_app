import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:legalz_hub_app/locator.dart';
import 'package:legalz_hub_app/services/attorney/attorney_appointments_service.dart';
import 'package:legalz_hub_app/services/customer/customer_appointments_service.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';

class InsideCallBloc {
  String channelName = "";
  int callID = 0;
  int meetingDurationInMin = 0;
  UserType userType = UserType.customer;
  ValueNotifier<RtcEngine?> engineNotifier = ValueNotifier<RtcEngine?>(null);

  String? appId = "67fa993d64a346e1a2587f4a8b96f569";
  String generatedCallToken = "";
  ValueNotifier<int?> remoteUidStatus = ValueNotifier<int?>(null);
  final infoStrings = <String>[];

  void handleReadingArguments(BuildContext context,
      {required Object? arguments}) {
    if (arguments != null) {
      final newArguments = arguments as Map<String, dynamic>;
      channelName = newArguments["channelName"] as String;
      callID = newArguments["callID"] as int;
      meetingDurationInMin = newArguments["durations"] as int;
      userType = newArguments["userType"] as UserType;

      joinAppointment(id: callID, channelName: channelName);
    }
  }

  Future<void> joinAppointment(
      {required int id, required String channelName}) async {
    if (userType == UserType.attorney) {
      return locator<AttorneyAppointmentsService>()
          .attorneyJoinCall(id: id, channelName: channelName)
          .then((value) {
        if (value != null) {
          generatedCallToken = value["data"];
          initializeCall(UserType.attorney);
        }
      });
    } else {
      return locator<CustomerAppointmentsService>()
          .customerJoinCall(id: id, channelName: channelName)
          .then((value) {
        if (value != null) {
          generatedCallToken = value["data"];
          initializeCall(UserType.customer);
        }
      });
    }
  }

  Future<void> exitAppointment({required int id}) async {
    if (userType == UserType.attorney) {
      return locator<AttorneyAppointmentsService>().attorneyEndCall(id: id);
    } else {
      return locator<CustomerAppointmentsService>().customerEndCall(id: id);
    }
  }

  Future<void> initializeCall(UserType userType) async {
    await _initAgoraRtcEngine(userType);
    _addAgoraEventHandlers();

    final VideoEncoderConfiguration configuration =
        const VideoEncoderConfiguration(
      dimensions: VideoDimensions(width: 1920, height: 1080),
      orientationMode: OrientationMode.orientationModeAdaptive,
    );

    await engineNotifier.value!.setVideoEncoderConfiguration(configuration);
    await engineNotifier.value!.joinChannel(
      token: generatedCallToken,
      channelId: channelName,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  Future<void> _initAgoraRtcEngine(UserType userType) async {
    engineNotifier.value = createAgoraRtcEngine();

    await engineNotifier.value!.initialize(RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    await engineNotifier.value!
        .setClientRole(role: ClientRoleType.clientRoleAudience);
    await engineNotifier.value!.enableVideo();
    await engineNotifier.value!.startPreview();
  }

  void _addAgoraEventHandlers() {
    engineNotifier.value!.registerEventHandler(
      RtcEngineEventHandler(
        onError: (code, error) {
          final info = 'onError: code: $code error: $error';
          infoStrings.add(info);
          debugPrint("+++==+++ onError $code $error");
        },
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          final info =
              'onJoinChannel: ${connection.channelId}, uid: ${connection.localUid}';
          infoStrings.add(info);
          debugPrint(
              "+++==+++ onJoinChannel: ${connection.channelId}, uid: ${connection.localUid}");
        },
        onLeaveChannel: (connection, stats) {
          infoStrings.add("onLeaveChannel ${connection.localUid} Leave");
          debugPrint("+++==+++ onLeaveChannel ${connection.localUid} Leave");
          remoteUidStatus.value = null;
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          final info = 'userJoined: $remoteUid';
          infoStrings.add(info);
          debugPrint("+++==+++ remote user $remoteUid joined");
          remoteUidStatus.value = remoteUid;
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          final info = 'userOffline: $remoteUid';
          infoStrings.add(info);
          remoteUidStatus.value = null;
          debugPrint("+++==+++ remote user $remoteUid left channel");
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          final info =
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token';
          infoStrings.add(info);
          debugPrint(
              '+++==+++ [onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );
  }
}
