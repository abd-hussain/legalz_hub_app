class AccountExperiance {
  AccountExperianceData? data;
  String? message;

  AccountExperiance({this.data, this.message});

  AccountExperiance.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? AccountExperianceData.fromJson(json['data'])
        : null;
    message = json['message'];
  }
}

class AccountExperianceData {
  String? cv;
  String? cert1;
  String? cert2;
  String? cert3;
  List<int>? majors;
  String? experienceSince;
  String? categoryName;
  int? categoryId;

  AccountExperianceData(
      {this.cv,
      this.cert1,
      this.cert2,
      this.cert3,
      this.majors,
      this.experienceSince,
      this.categoryId,
      this.categoryName});

  AccountExperianceData.fromJson(Map<String, dynamic> json) {
    cv = json['cv'];
    cert1 = json['cert1'];
    cert2 = json['cert2'];
    cert3 = json['cert3'];
    majors = json['majors'].cast<int>();
    experienceSince = json['experience_since'];
    categoryName = json['category_name'];
    categoryId = json['category_id'];
  }
}
