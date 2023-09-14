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
  String? season;
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
      this.season,
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
    season = json['season'];
    soilType = json['soil_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vendor_code'] = vendorCode;
    data['grower_name'] = growerName;
    data['area'] = area;
    data['crop_type'] = cropType;
    data['crop_variety'] = cropVariety;
    data['plantattion_ratooning_date'] = plantattionRatooningDate;
    data['area_acrs'] = areaAcrs;
    data['plant_name'] = plantName;
    data['name'] = name;
    data['season'] = season;
    data['soil_type'] = soilType;
    return data;
  }
}
