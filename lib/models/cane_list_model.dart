class CaneListModel {
  String? plantationStatus;
  String? area;
  String? circleOffice;
  int? name;
  String? growerCode;
  String? growerName;
  String? plantattionRatooningDate;

  CaneListModel(
      {this.plantationStatus,
      this.area,
      this.circleOffice,
      this.name,
      this.growerCode,
      this.growerName,
      this.plantattionRatooningDate});

  CaneListModel.fromJson(Map<String, dynamic> json) {
    plantationStatus = json['plantation_status'];
    area = json['area'];
    circleOffice = json['circle_office'];
    name = json['name'];
    growerCode = json['grower_code'];
    growerName = json['grower_name'];
    plantattionRatooningDate = json['plantattion_ratooning_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['plantation_status'] = plantationStatus;
    data['area'] = area;
    data['circle_office'] = circleOffice;
    data['name'] = name;
    data['grower_code'] = growerCode;
    data['grower_name'] = growerName;
    data['plantattion_ratooning_date'] = plantattionRatooningDate;
    return data;
  }
}
