class CommentsResponse {
  List<CommentsResponseData>? data;
  String? message;

  CommentsResponse({this.data, this.message});

  CommentsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CommentsResponseData>[];
      json['data'].forEach((v) {
        data!.add(CommentsResponseData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class CommentsResponseData {
  int? id;
  String? content;
  String? createdAt;
  int? up;
  int? down;
  int? postId;
  int? customersOwnerId;
  int? attorneyOwnerId;
  String? customerFirstName;
  String? customerLastName;
  String? customerProfileImg;
  String? attorneySuffixeName;
  String? attorneyFirstName;
  String? attorneyLastName;
  String? attorneyProfileImg;
  String? flagImage;

  CommentsResponseData(
      {this.id,
      this.content,
      this.createdAt,
      this.up,
      this.down,
      this.postId,
      this.customersOwnerId,
      this.attorneyOwnerId,
      this.customerFirstName,
      this.customerLastName,
      this.customerProfileImg,
      this.attorneySuffixeName,
      this.attorneyFirstName,
      this.attorneyLastName,
      this.attorneyProfileImg,
      this.flagImage});

  CommentsResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    createdAt = json['created_at'];
    up = json['up'];
    down = json['down'];
    postId = json['post_id'];
    customersOwnerId = json['customers_owner_id'];
    attorneyOwnerId = json['attorney_owner_id'];
    customerFirstName = json['customer_first_name'];
    customerLastName = json['customer_last_name'];
    customerProfileImg = json['customer_profile_img'];
    attorneySuffixeName = json['attorney_suffixe_name'];
    attorneyFirstName = json['attorney_first_name'];
    attorneyLastName = json['attorney_last_name'];
    attorneyProfileImg = json['attorney_profile_img'];
    flagImage = json['flag_image'];
  }
}