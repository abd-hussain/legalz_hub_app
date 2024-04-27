import 'package:legalz_hub_app/utils/mixins.dart';

class AddCommentToThePost implements Model {
  AddCommentToThePost({
    this.postId,
    this.userType,
    this.content,
  });
  int? postId;
  String? userType;
  String? content;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['post_id'] = postId;
    data['user_type'] = userType;
    data['content'] = content;
    return data;
  }
}
