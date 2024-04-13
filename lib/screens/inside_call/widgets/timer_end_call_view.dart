import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class TimerEndCallView extends StatefulWidget {
  final Function() timesup;
  final int meetingDurationInMin;

  const TimerEndCallView({
    super.key,
    required this.timesup,
    required this.meetingDurationInMin,
  });

  @override
  State<TimerEndCallView> createState() => _TimerEndCallViewState();
}

class _TimerEndCallViewState extends State<TimerEndCallView> {
  ValueNotifier<int> loadingForTimer = ValueNotifier<int>(0);
  int timerStartNumberSec = 0;
  int timerStartNumberMin = 0;

  @override
  void initState() {
    timerStartNumberSec = 0;
    timerStartNumberMin = widget.meetingDurationInMin;
    loadingForTimer.value = timerStartNumberSec;

    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    loadingForTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topRight,
        child: Column(
          children: [
            CustomText(
              title: AppLocalizations.of(context)!.metingendwihin,
              textAlign: TextAlign.center,
              fontSize: 16,
              textColor: const Color(0xff444444),
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder<Object>(
                valueListenable: loadingForTimer,
                builder: (context, snapshot, child) {
                  return Directionality(
                    textDirection: TextDirection.ltr,
                    child: CustomText(
                      title:
                          "${timerStartNumberMin > 9 ? "$timerStartNumberMin" : "0$timerStartNumberMin"} : ${timerStartNumberSec > 9 ? "$timerStartNumberSec" : "0$timerStartNumberSec"}",
                      textAlign: TextAlign.center,
                      fontSize: 15,
                      textColor: const Color(0xff444444),
                    ),
                  );
                }),
          ],
        ),
      ),
    ));
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_isTimerFinished()) {
          timer.cancel();
          widget.timesup();
        } else {
          _decrementTimer();
          loadingForTimer.value = timerStartNumberSec - 1;
        }
      },
    );
  }

  void _decrementTimer() {
    if (timerStartNumberSec > 0) {
      timerStartNumberSec--;
    } else if (timerStartNumberMin > 0) {
      timerStartNumberMin--;
      timerStartNumberSec = 59;
    }
  }

  bool _isTimerFinished() {
    return timerStartNumberMin == 0 && timerStartNumberSec == 0;
  }
}
