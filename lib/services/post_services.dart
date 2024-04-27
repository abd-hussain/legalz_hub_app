import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:legalz_hub_app/models/https/home_posts_response.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/mixins.dart';
import 'package:legalz_hub_app/utils/repository/http_repository.dart';
import 'package:legalz_hub_app/utils/repository/method_name_constractor.dart';

class PostService with Service {
  Future<dynamic> reportPost(
      {required int postId,
      required UserType userType,
      required String reason}) async {
    return repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.reportPost,
      queryParam: {
        "post_id": postId,
        "user_type": userType == UserType.attorney ? "attorney" : "customer",
        "reason": reason
      },
    );
  }

  Future<PostResponse> getHomePosts(
      {required int catId, required int skip, int limit = 10}) async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.homePosts,
      queryParam: {"cat_id": catId, "skip": skip, "limit": limit},
    );
    return PostResponse.fromJson(response);
  }

  Future<dynamic> addPost(
      {required String catId, required String content, File? postImg}) async {
    final FormData formData = FormData();

    formData.fields.add(MapEntry("content", content));
    formData.fields.add(MapEntry("cat_id", catId));

    if (postImg != null) {
      final String fileName = postImg.path.split('/').last;
      formData.files.add(
        MapEntry(
          "post_img",
          MultipartFile.fromFileSync(
            postImg.path,
            filename: fileName,
            contentType: MediaType('image', fileName.split('.').last),
          ),
        ),
      );
    }

    return repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.addPost,
      formData: formData,
    );
  }

  Future<dynamic> editPost(
      {required String postId,
      required String catId,
      required String content,
      String? postImg}) async {
    final FormData formData = FormData();

    formData.fields.add(MapEntry("content", content));
    formData.fields.add(MapEntry("cat_id", catId));
    formData.fields.add(MapEntry("post_id", postId));

    if (postImg != null) {
      final String fileName = postImg.split('/').last;
      formData.files.add(
        MapEntry(
          "post_img",
          MultipartFile.fromFileSync(
            postImg,
            filename: fileName,
            contentType: MediaType('image', fileName.split('.').last),
          ),
        ),
      );
    }

    return repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.editPost,
      formData: formData,
    );
  }

  Future<dynamic> removePost({required int postId}) async {
    final response = await repository.callRequest(
      requestType: RequestType.delete,
      methodName: MethodNameConstant.deletePost,
      queryParam: {"post_id": postId},
    );
    return response;
  }
}
