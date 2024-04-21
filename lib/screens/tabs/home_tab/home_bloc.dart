import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/locator.dart';
import 'package:legalz_hub_app/models/https/home_banners_response.dart';
import 'package:legalz_hub_app/models/https/home_posts_response.dart';
import 'package:legalz_hub_app/models/report_model.dart';
import 'package:legalz_hub_app/services/home_services.dart';
import 'package:legalz_hub_app/services/noticitions_services.dart';
import 'package:legalz_hub_app/services/post_services.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/mixins.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeBloc extends Bloc<HomeService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);
  UserType userType = UserType.customer;
  TabController? tabController;

  List<ReportPostModel> reportList = [];

  StreamController<List<PostResponseData>?> postsStreamController =
      StreamController<List<PostResponseData>?>.broadcast();

  List<ReportPostModel> fillReportList(BuildContext context) {
    return [
      ReportPostModel(
        title: AppLocalizations.of(context)!.reporttitle1,
        desc: AppLocalizations.of(context)!.reportdesc1,
        otherNote: "",
      ),
      ReportPostModel(
        title: AppLocalizations.of(context)!.reporttitle2,
        desc: AppLocalizations.of(context)!.reportdesc2,
        otherNote: "",
      ),
      ReportPostModel(
          title: AppLocalizations.of(context)!.reporttitle3,
          desc: AppLocalizations.of(context)!.reportdesc3,
          otherNote: ""),
      ReportPostModel(
          title: AppLocalizations.of(context)!.reporttitle4,
          desc: AppLocalizations.of(context)!.reportdesc4,
          otherNote: ""),
      ReportPostModel(
          title: AppLocalizations.of(context)!.reporttitle5,
          desc: AppLocalizations.of(context)!.reportdesc5,
          otherNote: ""),
      ReportPostModel(
          title: AppLocalizations.of(context)!.reporttitle6,
          desc: AppLocalizations.of(context)!.reportdesc6,
          otherNote: ""),
      ReportPostModel(
          title: AppLocalizations.of(context)!.reporttitle7,
          desc: AppLocalizations.of(context)!.reportdesc7,
          otherNote: ""),
    ];
  }

  Future<List<HomeBannerResponseData>?> getHomeBanners() async {
    final value = await service.getHomeBanners(userType);
    if (value.data != null) {
      return value.data ?? [];
    } else {
      return [];
    }
  }

  Future<void> getHomePosts({required int catId, required int skip}) async {
    final value =
        await locator<PostService>().getHomePosts(catId: catId, skip: skip);
    if (value.data != null) {
      postsStreamController.sink.add(value.data);
    }
  }

  void callRegisterTokenRequest() async {
    final String token = box.get(DatabaseFieldConstant.pushNotificationToken);
    await locator<NotificationsService>().registerToken(token, userType);
  }

  void handleTapControllerListener() {
    tabController!.addListener(() async {
      getHomePosts(catId: tabController!.index, skip: 0);
    });
  }

  Future<void> addNewPost(
      {required int catId, required String content, File? postImg}) async {
    await locator<PostService>()
        .addPost(catId: catId.toString(), content: content, postImg: postImg);
  }

  Future<dynamic> reportPost(
      {required int postId, required String reason}) async {
    return await locator<PostService>()
        .reportPost(postId: postId, reason: reason, userType: userType);
  }

  @override
  onDispose() {
    tabController?.dispose();
  }
}
