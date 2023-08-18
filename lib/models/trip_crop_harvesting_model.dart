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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['grower_code'] = this.growerCode;
    data['grower_name'] = this.growerName;
    data['area'] = this.area;
    data['crop_variety'] = this.cropVariety;
    data['plantattion_ratooning_date'] = this.plantattionRatooningDate;
    data['survey_number'] = this.surveyNumber;
    data['area_acrs'] = this.areaAcrs;
    data['name'] = this.name;
    return data;
  }
}
