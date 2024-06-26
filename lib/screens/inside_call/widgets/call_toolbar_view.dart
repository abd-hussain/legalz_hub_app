import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

class CallToolBarView extends StatefulWidget {
  const CallToolBarView(
      {super.key, required this.engine, required this.callEnd});
  final RtcEngine engine;
  final Function callEnd;

  @override
  State<CallToolBarView> createState() => _CallToolBarViewState();
}

class _CallToolBarViewState extends State<CallToolBarView> {
  ValueNotifier<bool> mutedStatus = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ValueListenableBuilder<bool>(
              valueListenable: mutedStatus,
              builder: (context, snapshot, child) {
                return RawMaterialButton(
                  onPressed: onToggleMute,
                  shape: const CircleBorder(),
                  fillColor: snapshot ? Colors.blueAccent : Colors.white,
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    snapshot ? Icons.mic_off : Icons.mic,
                    color: snapshot ? Colors.white : Colors.blueAccent,
                    size: 20,
                  ),
                );
              }),
          RawMaterialButton(
            onPressed: () => widget.callEnd(),
            shape: const CircleBorder(),
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15),
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35,
            ),
          ),
          RawMaterialButton(
            onPressed: onSwitchCamera,
            shape: const CircleBorder(),
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12),
            child: const Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20,
            ),
          )
        ],
      ),
    );
  }

  void onSwitchCamera() {
    widget.engine.switchCamera();
  }

  void onToggleMute() {
    mutedStatus.value = !mutedStatus.value;
    widget.engine.muteLocalAudioStream(mutedStatus.value);
  }
}
