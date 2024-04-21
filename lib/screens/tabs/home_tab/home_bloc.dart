import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/locator.dart';
import 'package:legalz_hub_app/models/https/home_banners_response.dart';
import 'package:legalz_hub_app/models/https/home_posts_response.dart';
import 'package:legalz_hub_app/services/home_services.dart';
import 'package:legalz_hub_app/services/noticitions_services.dart';
import 'package:legalz_hub_app/services/post_services.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/mixins.dart';

class HomeBloc extends Bloc<HomeService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);
  UserType userType = UserType.customer;
  TabController? tabController;

  StreamController<List<PostResponseData>?> postsStreamController =
      StreamController<List<PostResponseData>?>.broadcast();

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

  @override
  onDispose() {
    tabController?.dispose();
  }
}
