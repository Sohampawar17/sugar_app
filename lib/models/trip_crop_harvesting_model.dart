class cropharvestingModel {
  String? id;
  String? growerCode;
  String? growerName;
  String? area;
  String? cropVariety;
  String? plantattionRatooningDate;
  String? surveyNumber;
  double? areaAcrs;
  String? name;

  cropharvestingModel(
      {this.id,
      this.growerCode,
      this.growerName,
      this.area,
      this.cropVariety,
      this.plantattionRatooningDate,
      this.surveyNumber,
      this.areaAcrs,
      this.name});

  cropharvestingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    growerCode = json['grower_code'];
    growerName = json['grower_name'];
    area = json['area'];
    cropVariety = json['crop_variety'];
    plantattionRatooningDate = json['plantattion_ratooning_date'];
    surveyNumber = json['survey_number'];
    areaAcrs = json['area_acrs'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['grower_code'] = growerCode;
    data['grower_name'] = growerName;
    data['area'] = area;
    data['crop_variety'] = cropVariety;
    data['plantattion_ratooning_date'] = plantattionRatooningDate;
    data['survey_number'] = surveyNumber;
    data['area_acrs'] = areaAcrs;
    data['name'] = name;
    return data;
  }
}
