class HomeResponse {
  List<MainBannerData>? data;
  String? message;

  HomeResponse({this.data, this.message});

  HomeResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MainBannerData>[];
      json['data'].forEach((v) {
        data!.add(MainBannerData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class MainBannerData {
  String? image;
  String? actionType;

  MainBannerData({this.image, this.actionType});

  MainBannerData.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    actionType = json['action_type'];
  }
}
