import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'custom_text.dart';

class LoadingView extends StatelessWidget {
  final String? title;
  final bool fullScreen;

  const LoadingView({super.key, this.title, this.fullScreen = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent.withOpacity(fullScreen ? 0.8 : 0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 70,
              width: 70,
              child: LoadingIndicator(
                  indicatorType: Indicator.ballSpinFadeLoader,
                  colors: [Color(0xff4CB6EA)],
                  strokeWidth: 1,
                  backgroundColor: Colors.transparent,
                  pathBackgroundColor: Colors.transparent),
            ),
            const SizedBox(height: 12),
            CustomText(
              title: title ?? '',
              fontSize: 14,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
