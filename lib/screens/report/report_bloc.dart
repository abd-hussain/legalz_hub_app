import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/models/https/report_request.dart';
import 'package:legalz_hub_app/services/report_service.dart';
import 'package:legalz_hub_app/utils/constants/constant.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/loading_status.dart';
import 'package:legalz_hub_app/utils/enums/report_type.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/mixins.dart';

class ReportBloc extends Bloc<ReportService> {
  var box = Hive.box(DatabaseBoxConstant.userInfo);
  UserType userType = UserType.customer;

  TextEditingController textController = TextEditingController();
  ReportPageType? pageType;
  ValueNotifier<bool> enableSubmitBtn = ValueNotifier<bool>(false);
  ValueNotifier<LoadingStatus> loadingStatus =
      ValueNotifier<LoadingStatus>(LoadingStatus.idle);
  File? attach1;
  File? attach2;
  File? attach3;

  void validationFields() {
    enableSubmitBtn.value = false;

    if (textController.text.isNotEmpty) {
      enableSubmitBtn.value = true;
    }
  }

  void handleReadingArguments({required Object? arguments}) {
    if (arguments != null) {
      final newArguments = arguments as Map<String, dynamic>;
      pageType = newArguments[AppConstant.reportType] as ReportPageType?;
      userType = box.get(DatabaseFieldConstant.userType) == "customer"
          ? UserType.customer
          : UserType.attorney;
    }
  }

  Future<dynamic> callRequest(BuildContext context) {
    final model = ReportRequest(
      content: textController.text,
      userId: box.get(DatabaseFieldConstant.userid).toString(),
      attach1: attach1,
      attach2: attach2,
      attach3: attach3,
      userType: userType,
    );

    if (pageType == ReportPageType.issue) {
      return service.addBugIssue(reportData: model);
    } else {
      return service.addSuggestion(reportData: model);
    }
  }

  @override
  onDispose() {
    attach1 = null;
    attach2 = null;
    attach3 = null;
    textController.dispose();
    enableSubmitBtn.dispose();
    loadingStatus.dispose();
  }
}
