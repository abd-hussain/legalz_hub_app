class Suffix {
  List<SuffixData>? data;
  String? message;

  Suffix({this.data, this.message});

  Suffix.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SuffixData>[];
      json['data'].forEach((v) {
        data!.add(SuffixData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class SuffixData {
  int? id;
  String? name;

  SuffixData({this.id, this.name});

  SuffixData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
