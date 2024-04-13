import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

class MyCameraView extends StatelessWidget {
  final RtcEngine rtcEngine;
  const MyCameraView({super.key, required this.rtcEngine});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(75),
          child: SizedBox(
              width: 150,
              height: 150,
              child: AgoraVideoView(
                controller: VideoViewController(
                  rtcEngine: rtcEngine,
                  canvas: const VideoCanvas(uid: 0),
                ),
              )),
        ),
      ),
    );
  }
}
