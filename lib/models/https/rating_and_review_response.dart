class RatingAndReviewResponse {
  RatingAndReviewResponse({this.data, this.message});

  RatingAndReviewResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <RatingAndReviewResponseData>[];
      json['data'].forEach((v) {
        data!.add(RatingAndReviewResponseData.fromJson(v));
      });
    }
    message = json['message'];
  }
  List<RatingAndReviewResponseData>? data;
  String? message;
}

class RatingAndReviewResponseData {
  RatingAndReviewResponseData(
      {this.id,
      this.clientId,
      this.stars,
      this.comment,
      this.attorneyResponse,
      this.createdAt,
      this.profileImg,
      this.firstName,
      this.lastName,
      this.countryId,
      this.flagImage});

  RatingAndReviewResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    stars = json['stars'];
    comment = json['comment'];
    attorneyResponse = json['attorney_response'];
    createdAt = json['created_at'];
    profileImg = json['profile_img'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    countryId = json['country_id'];
    flagImage = json['flag_image'];
  }
  int? id;
  int? clientId;
  double? stars;
  String? comment;
  String? attorneyResponse;
  String? createdAt;
  String? profileImg;
  String? firstName;
  String? lastName;
  int? countryId;
  String? flagImage;
}
