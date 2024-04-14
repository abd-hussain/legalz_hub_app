class HomeBannerResponse {
  List<HomeBannerResponseData>? data;
  String? message;

  HomeBannerResponse({this.data, this.message});

  HomeBannerResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <HomeBannerResponseData>[];
      json['data'].forEach((v) {
        data!.add(HomeBannerResponseData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class HomeBannerResponseData {
  String? image;
  String? actionType;

  HomeBannerResponseData({this.image, this.actionType});

  HomeBannerResponseData.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    actionType = json['action_type'];
  }
}
