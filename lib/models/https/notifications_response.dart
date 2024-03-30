class NotificationsResponse {
  List<NotificationsResponseData>? data;
  String? message;

  NotificationsResponse({this.data, this.message});

  NotificationsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <NotificationsResponseData>[];
      if (json['data'].isNotEmpty) {
        json['data'].forEach((v) {
          data!.add(NotificationsResponseData.fromJson(v));
        });
      }
    }
    message = json['message'];
  }
}

class NotificationsResponseData {
  int? id;
  String? title;
  String? content;
  bool? readed;
  String? createdAt;

  NotificationsResponseData(
      {this.id, this.title, this.content, this.readed, this.createdAt});

  NotificationsResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    readed = json['readed'];
    createdAt = json['created_at'];
  }
}
