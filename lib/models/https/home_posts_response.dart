class PostResponse {
  List<PostResponseData>? data;
  String? message;

  PostResponse({this.data, this.message});

  PostResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PostResponseData>[];
      json['data'].forEach((v) {
        data!.add(PostResponseData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class PostResponseData {
  int? id;
  String? content;
  String? postImg;
  int? reportCount;
  int? customersOwnerId;
  bool? published;
  int? categoryId;
  String? createdAt;
  String? firstName;
  String? lastName;
  String? profileImg;
  String? flagImage;
  int? commentCount;

  PostResponseData({
    this.id,
    this.content,
    this.postImg,
    this.reportCount,
    this.customersOwnerId,
    this.published,
    this.categoryId,
    this.createdAt,
    this.firstName,
    this.lastName,
    this.profileImg,
    this.flagImage,
    this.commentCount,
  });

  PostResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    postImg = json['post_img'];
    reportCount = json['report_count'];
    customersOwnerId = json['customers_owner_id'];
    published = json['published'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profileImg = json['profile_img'];
    flagImage = json['flag_image'];
    commentCount = json['comment_count'];
  }
}
