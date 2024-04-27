import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/utils/constants/constant.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/loading_status.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class WebViewBloc {
  String webViewUrl = "";
  String pageTitle = "";
  ValueNotifier<LoadingStatus> loadingStatus =
      ValueNotifier<LoadingStatus>(LoadingStatus.idle);
  WebViewXController? webviewController;
  UserType userType = UserType.customer;
  Box box = Hive.box(DatabaseBoxConstant.userInfo);

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

  void onDispose() {
    loadingStatus.dispose();
  }
}
