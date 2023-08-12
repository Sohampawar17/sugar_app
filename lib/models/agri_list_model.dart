class AgriListModel {
  String? cropType;
  String? cropVariety;
  String? date;
  double? area;
  String? village;
  String? name;

  AgriListModel(
      {this.cropType,
      this.cropVariety,
      this.date,
      this.area,
      this.village,
      this.name});

  AgriListModel.fromJson(Map<String, dynamic> json) {
    cropType = json['crop_type'];
    cropVariety = json['crop_variety'];
    date = json['date'];
    area = json['area'];
    village = json['village'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['crop_type'] = this.cropType;
    data['crop_variety'] = this.cropVariety;
    data['date'] = this.date;
    data['area'] = this.area;
    data['village'] = this.village;
    data['name'] = this.name;
    return data;
  }
}
