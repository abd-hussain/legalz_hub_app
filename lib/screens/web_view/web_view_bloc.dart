import 'package:flutter/material.dart';
import 'package:legalz_hub_app/utils/constants/constant.dart';
import 'package:legalz_hub_app/utils/enums/loading_status.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class WebViewBloc {
  String webViewUrl = "";
  String pageTitle = "";
  ValueNotifier<LoadingStatus> loadingStatus =
      ValueNotifier<LoadingStatus>(LoadingStatus.idle);
  WebViewXController? webviewController;

  void extractArguments(BuildContext context) {
    loadingStatus.value = LoadingStatus.inprogress;
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      webViewUrl = arguments[AppConstant.webViewPageUrl];
      pageTitle = arguments[AppConstant.pageTitle];
      loadingStatus.value = LoadingStatus.finish;
    }
  }

  onDispose() {
    loadingStatus.dispose();
  }
}
