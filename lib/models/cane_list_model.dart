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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plantation_status'] = this.plantationStatus;
    data['area'] = this.area;
    data['circle_office'] = this.circleOffice;
    data['name'] = this.name;
    data['grower_code'] = this.growerCode;
    data['grower_name'] = this.growerName;
    data['plantattion_ratooning_date'] = this.plantattionRatooningDate;
    return data;
  }
}
