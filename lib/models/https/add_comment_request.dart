import 'package:legalz_hub_app/utils/mixins.dart';

class AddCommentToThePost implements Model {
  int? postId;
  String? userType;
  int? up;
  int? down;
  String? content;

  AddCommentToThePost({
    this.postId,
    this.userType,
    this.up,
    this.down,
    this.content,
  });

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['post_id'] = postId;
    data['user_type'] = userType;
    data['up'] = up;
    data['down'] = down;
    data['content'] = content;
    return data;
  }
}
