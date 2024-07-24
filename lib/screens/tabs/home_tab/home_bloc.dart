import 'dart:async';
// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/locator.dart';
// import 'package:legalz_hub_app/models/https/add_comment_request.dart';
// import 'package:legalz_hub_app/models/https/comments_response.dart';
import 'package:legalz_hub_app/models/https/home_banners_response.dart';
import 'package:legalz_hub_app/models/https/home_posts_response.dart';
import 'package:legalz_hub_app/models/report_model.dart';
// import 'package:legalz_hub_app/services/comment_post_services.dart';
import 'package:legalz_hub_app/services/home_services.dart';
import 'package:legalz_hub_app/services/noticitions_services.dart';
import 'package:legalz_hub_app/services/post_services.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/error/exceptions.dart';
import 'package:legalz_hub_app/utils/mixins.dart';

class HomeBloc extends Bloc<HomeService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);
  UserType userType = UserType.customer;
  TabController? tabController;
  int skipPost = 0;

  List<ReportPostModel> reportList = [];

  StreamController<List<PostResponseData>?> postsStreamController =
      StreamController<List<PostResponseData>?>.broadcast();

  List<PostResponseData> listOfPost = [];

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

  Future<void> pullRefresh() async {
    return Future.delayed(
      const Duration(milliseconds: 1000),
      () {
        skipPost = 0;
        getHomePosts(
            catId: tabController!.index, skip: skipPost, newRequest: true);
      },
    );
  }

  Future<List<HomeBannerResponseData>?> getHomeBanners() async {
    final value = await service.getHomeBanners(userType);
    if (value.data != null) {
      return value.data ?? [];
    } else {
      return [];
    }
  }

  Future<List<PostResponseData>?> getHomePosts(
      {required int catId, required int skip, required bool newRequest}) async {
    final value =
        await locator<PostService>().getHomePosts(catId: catId, skip: skip);
    if (value.data != null) {
      if (!newRequest) {
        listOfPost.addAll(value.data!);
        postsStreamController.sink.add(listOfPost);
      } else {
        listOfPost = [];
        listOfPost = value.data!;
        postsStreamController.sink.add(listOfPost);
      }
      return value.data!;
    } else {
      return null;
    }
  }

  Future<void> callRegisterTokenRequest(BuildContext context) async {
    final String token =
        box.get(DatabaseFieldConstant.pushNotificationToken) ?? "";

    print("token $token");

    try {
      await locator<NotificationsService>().registerToken(token, userType);
    } on ConnectionException {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      scaffoldMessenger.showSnackBar(
        SnackBar(
            content: Text(AppLocalizations.of(context)!
                .pleasecheckyourinternetconnection)),
      );
    }
  }

  // void handleTapControllerListener() {
  //   skipPost = 0;

  //   getHomePosts(catId: 0, skip: skipPost, newRequest: true);
  //   tabController!.addListener(() async {
  //     skipPost = 0;

  //     await getHomePosts(
  //         catId: tabController!.index, skip: skipPost, newRequest: true);
  //   });
  // }

  // Future<void> addNewPost(
  //     {required int catId, required String content, File? postImg}) async {
  //   await locator<PostService>()
  //       .addPost(catId: catId.toString(), content: content, postImg: postImg);
  // }

  // Future<void> editPost(
  //     {required int postId,
  //     required int catId,
  //     required String content,
  //     File? postImg}) async {
  //   await locator<PostService>().editPost(
  //       postId: postId.toString(),
  //       catId: catId.toString(),
  //       content: content,
  //       postImg: postImg);
  // }

  // Future<dynamic> reportPost(
  //     {required int postId, required String reason}) async {
  //   return locator<PostService>()
  //       .reportPost(postId: postId, reason: reason, userType: userType);
  // }

  // Future<dynamic> deletePost({required int postId}) async {
  //   return locator<PostService>().removePost(postId: postId);
  // }

  // Future<CommentsResponse> getPostComments({required int postId}) async {
  //   return locator<CommentPostService>().getCommentsForPost(postId: postId);
  // }

  // Future<dynamic> addNewComment(
  //     {required int postId, required String content}) async {
  //   await locator<CommentPostService>().addCommentOnPost(
  //       model: AddCommentToThePost(
  //     postId: postId,
  //     content: content,
  //     userType: userType == UserType.attorney ? "attorney" : "customer",
  //   ));
  // }

  // Future<dynamic> deleteComment({required int commentId}) async {
  //   await locator<CommentPostService>().removeCommentOnPost(
  //     commentId: commentId,
  //     userType: userType,
  //   );
  // }

  @override
  void onDispose() {
    tabController?.dispose();
  }
}
