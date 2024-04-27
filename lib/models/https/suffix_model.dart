class Suffix {
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
  List<SuffixData>? data;
  String? message;
}

class SuffixData {
  SuffixData({this.id, this.name});

  SuffixData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
  int? id;
  String? name;
}
