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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['crop_type'] = cropType;
    data['crop_variety'] = cropVariety;
    data['date'] = date;
    data['area'] = area;
    data['village'] = village;
    data['name'] = name;
    return data;
  }
}
