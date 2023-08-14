class CropSampling {
  String? name;
  String? id;
  double? brixBottom;
  double? brixMiddle;
  double? brixTop;
  int? averageBrix;
  int? noOfPairs;
  String? season;
  String? plantationStatus;
  String? plantName;
  String? formNumber;
  String? growerCode;
  String? growerName;
  String? mobileNo;
  String? companyName;
  String? isKisanCard;
  String? surveyNumber;
  String? area;
  String? country;
  String? circleOffice;
  String? taluka;
  String? district;
  String? states;
  String? routeKm;
  String? cropType;
  String? cropVariety;
  int? areaAcrs;
  String? plantattionRatooningDate;
  String? plantationSystem;
  String? irrigationSource;
  String? irrigationMethod;
  String? soilType;
  String? seedMaterial;
  String? roadSide;

  CropSampling(
      {this.name,
      this.id,
      this.brixBottom,
      this.brixMiddle,
      this.brixTop,
      this.averageBrix,
      this.noOfPairs,
      this.season,
      this.plantationStatus,
      this.plantName,
      this.formNumber,
      this.growerCode,
      this.growerName,
      this.mobileNo,
      this.companyName,
      this.isKisanCard,
      this.surveyNumber,
      this.area,
      this.country,
      this.circleOffice,
      this.taluka,
      this.district,
      this.states,
      this.routeKm,
      this.cropType,
      this.cropVariety,
      this.areaAcrs,
      this.plantattionRatooningDate,
      this.plantationSystem,
      this.irrigationSource,
      this.irrigationMethod,
      this.soilType,
      this.seedMaterial,
      this.roadSide});

  CropSampling.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    brixBottom = json['brix_bottom'];
    brixMiddle = json['brix_middle'];
    brixTop = json['brix_top'];
    averageBrix = json['average_brix'];
    noOfPairs = json['no_of_pairs'];
    season = json['season'];
    plantationStatus = json['plantation_status'];
    plantName = json['plant_name'];
    formNumber = json['form_number'];
    growerCode = json['grower_code'];
    growerName = json['grower_name'];
    mobileNo = json['mobile_no'];
    companyName = json['company_name'];
    isKisanCard = json['is_kisan_card'];
    surveyNumber = json['survey_number'];
    area = json['area'];
    country = json['country'];
    circleOffice = json['circle_office'];
    taluka = json['taluka'];
    district = json['district'];
    states = json['states'];
    routeKm = json['route_km'];
    cropType = json['crop_type'];
    cropVariety = json['crop_variety'];
    areaAcrs = json['area_acrs'];
    plantattionRatooningDate = json['plantattion_ratooning_date'];
    plantationSystem = json['plantation_system'];
    irrigationSource = json['irrigation_source'];
    irrigationMethod = json['irrigation_method'];
    soilType = json['soil_type'];
    seedMaterial = json['seed_material'];
    roadSide = json['road_side'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['brix_bottom'] = this.brixBottom;
    data['brix_middle'] = this.brixMiddle;
    data['brix_top'] = this.brixTop;
    data['average_brix'] = this.averageBrix;
    data['no_of_pairs'] = this.noOfPairs;
    data['season'] = this.season;
    data['plantation_status'] = this.plantationStatus;
    data['plant_name'] = this.plantName;
    data['form_number'] = this.formNumber;
    data['grower_code'] = this.growerCode;
    data['grower_name'] = this.growerName;
    data['mobile_no'] = this.mobileNo;
    data['company_name'] = this.companyName;
    data['is_kisan_card'] = this.isKisanCard;
    data['survey_number'] = this.surveyNumber;
    data['area'] = this.area;
    data['country'] = this.country;
    data['circle_office'] = this.circleOffice;
    data['taluka'] = this.taluka;
    data['district'] = this.district;
    data['states'] = this.states;
    data['route_km'] = this.routeKm;
    data['crop_type'] = this.cropType;
    data['crop_variety'] = this.cropVariety;
    data['area_acrs'] = this.areaAcrs;
    data['plantattion_ratooning_date'] = this.plantattionRatooningDate;
    data['plantation_system'] = this.plantationSystem;
    data['irrigation_source'] = this.irrigationSource;
    data['irrigation_method'] = this.irrigationMethod;
    data['soil_type'] = this.soilType;
    data['seed_material'] = this.seedMaterial;
    data['road_side'] = this.roadSide;
    return data;
  }
}
