import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/models/https/update_attorney_account_request.dart';
import 'package:legalz_hub_app/services/attorney/attorney_account_experiance_service.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/loading_status.dart';
import 'package:legalz_hub_app/utils/mixins.dart';

class EditExperienceBloc extends Bloc<AttorneyAccountExperianceService> {
  ValueNotifier<bool> enableSaveButton = ValueNotifier<bool>(false);
  final box = Hive.box(DatabaseBoxConstant.userInfo);
  ValueNotifier<LoadingStatus> loadingStatusNotifier =
      ValueNotifier<LoadingStatus>(LoadingStatus.idle);

  TextEditingController categoryController = TextEditingController();
  TextEditingController experianceSinceController = TextEditingController();

  int? categoryId;

  File? cv;
  String cvFileUrl = "";

  File? cert1;
  String cert1FileUrl = "";

  File? cert2;
  String cert2FileUrl = "";

  File? cert3;
  String cert3FileUrl = "";

  getProfileExperiance() async {
    loadingStatusNotifier.value = LoadingStatus.inprogress;

    await service.getProfileExperiance().then((value) {
      final data = value.data;

      if (data != null) {
        categoryController.text = data.categoryName ?? "";
        experianceSinceController.text = data.experienceSince ?? "";
        categoryId = data.categoryId ?? 0;

        cvFileUrl = data.cv ?? "";
        cert1FileUrl = data.cert1 ?? "";
        cert2FileUrl = data.cert2 ?? "";
        cert3FileUrl = data.cert3 ?? "";
      }
      loadingStatusNotifier.value = LoadingStatus.finish;
    });
  }

  Future<dynamic> updateProfileExperiance() async {
    return await service.updateProfileExperiance(
      account: UpdateAccountExperianceRequest(
        experienceSince: experianceSinceController.text,
        cv: cv,
        cert1: cert1,
        cert2: cert2,
        cert3: cert3,
        categoryId: categoryId,
      ),
    );
  }

  validateFields() {
    enableSaveButton.value = false;

    if (experianceSinceController.text.isNotEmpty &&
        (cv != null || cvFileUrl.isNotEmpty) &&
        (cert1 != null || cert1FileUrl.isNotEmpty)) {
      enableSaveButton.value = true;
    }
  }

  @override
  onDispose() {
    loadingStatusNotifier.dispose();
  }
}
