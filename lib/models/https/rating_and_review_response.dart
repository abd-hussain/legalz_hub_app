class RatingAndReviewResponse {
  List<RatingAndReviewResponseData>? data;
  String? message;

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
}

class RatingAndReviewResponseData {
  int? id;
  int? clientId;
  double? stars;
  String? comment;
  String? mentorResponse;
  String? createdAt;
  String? profileImg;
  String? firstName;
  String? lastName;
  int? countryId;
  String? flagImage;

  RatingAndReviewResponseData(
      {this.id,
      this.clientId,
      this.stars,
      this.comment,
      this.mentorResponse,
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
    mentorResponse = json['mentor_response'];
    createdAt = json['created_at'];
    profileImg = json['profile_img'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    countryId = json['country_id'];
    flagImage = json['flag_image'];
  }
}
