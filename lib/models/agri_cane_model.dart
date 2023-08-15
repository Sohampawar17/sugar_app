class AgriCane {
  String? vendorCode;
  String? growerName;
  String? area;
  String? cropType;
  String? cropVariety;
  String? plantattionRatooningDate;
  double? areaAcrs;
  String? plantName;
  int? name;
  String? soilType;

  AgriCane(
      {this.vendorCode,
      this.growerName,
      this.area,
      this.cropType,
      this.cropVariety,
      this.plantattionRatooningDate,
      this.areaAcrs,
      this.plantName,
      this.name,
      this.soilType});

  AgriCane.fromJson(Map<String, dynamic> json) {
    vendorCode = json['vendor_code'];
    growerName = json['grower_name'];
    area = json['area'];
    cropType = json['crop_type'];
    cropVariety = json['crop_variety'];
    plantattionRatooningDate = json['plantattion_ratooning_date'];
    areaAcrs = json['area_acrs'];
    plantName = json['plant_name'];
    name = json['name'];
    soilType = json['soil_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_code'] = this.vendorCode;
    data['grower_name'] = this.growerName;
    data['area'] = this.area;
    data['crop_type'] = this.cropType;
    data['crop_variety'] = this.cropVariety;
    data['plantattion_ratooning_date'] = this.plantattionRatooningDate;
    data['area_acrs'] = this.areaAcrs;
    data['plant_name'] = this.plantName;
    data['name'] = this.name;
    data['soil_type'] = this.soilType;
    return data;
  }
}
