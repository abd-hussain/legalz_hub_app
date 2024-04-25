import 'package:legalz_hub_app/models/https/add_comment_request.dart';
import 'package:legalz_hub_app/models/https/comments_response.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/mixins.dart';
import 'package:legalz_hub_app/utils/repository/http_repository.dart';
import 'package:legalz_hub_app/utils/repository/method_name_constractor.dart';

class CommentPostService with Service {
  Future<CommentsResponse> getCommentsForPost({required int postId}) async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.postComments,
      queryParam: {"post_id": postId},
    );

    return CommentsResponse.fromJson(response);
  }

  Future<dynamic> addCommentOnPost({required AddCommentToThePost model}) async {
    final response = await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.postComments,
      postBody: model,
    );
    return response;
  }

  Future<dynamic> removeCommentOnPost(
      {required int commentId, required UserType userType}) async {
    final response = await repository.callRequest(
      requestType: RequestType.delete,
      methodName: MethodNameConstant.postComments,
      queryParam: {
        "comment_id": commentId,
        "user_type": userType == UserType.attorney ? "attorney" : "customer",
      },
    );
    return response;
  }
}
