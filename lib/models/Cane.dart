class Cane {
  int? name;
  String? season;
  String? plantationStatus;
  String? plantName;
  String? formNumber;
  String? growerCode;
  String? vendorCode;
  String? growerName;
  String? mobileNo;
  String? companyName;
  String? isKisanCard;
  String? area;
  String? circleOffice;
  String? country;
  String? taluka;
  String? district;
  String? route;
  String? states;
  double? routeKm;
  String? surveyNumber;
  String? cropType;
  String? isMachine;
  String? cropVariety;
  double? areaAcrs;
  String? plantationSystem;
  String? plantattionRatooningDate;
  String? basalDate;
  String? irrigationSource;
  String? irrigationMethod;
  String? developmentPlot;
  String? soilType;
  String? seedMaterial;
  String? seedType;
  String? roadSide;
  String? longitude;
  String? latitude;
  String? city;
  String? state;

  Cane(
      {this.name,
      this.season,
      this.plantationStatus,
      this.plantName,
      this.formNumber,
      this.growerCode,
      this.vendorCode,
      this.growerName,
      this.mobileNo,
      this.companyName,
      this.isKisanCard,
      this.area,
      this.circleOffice,
      this.country,
      this.taluka,
      this.district,
      this.route,
      this.states,
      this.routeKm,
      this.surveyNumber,
      this.cropType,
      this.isMachine,
      this.cropVariety,
      this.areaAcrs,
      this.plantationSystem,
      this.plantattionRatooningDate,
      this.basalDate,
      this.irrigationSource,
      this.irrigationMethod,
      this.developmentPlot,
      this.soilType,
      this.seedMaterial,
      this.seedType,
      this.roadSide,
      this.longitude,
      this.latitude,
      this.city,
      this.state});

  Cane.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    season = json['season'];
    plantationStatus = json['plantation_status'];
    plantName = json['plant_name'];
    formNumber = json['form_number'];
    growerCode = json['grower_code'];
    vendorCode = json['vendor_code'];
    growerName = json['grower_name'];
    mobileNo = json['mobile_no'];
    companyName = json['company_name'];
    isKisanCard = json['is_kisan_card'];
    area = json['area'];
    circleOffice = json['circle_office'];
    country = json['country'];
    taluka = json['taluka'];
    district = json['district'];
    route = json['route'];
    states = json['states'];
    routeKm = json['route_km'];
    surveyNumber = json['survey_number'];
    cropType = json['crop_type'];
    isMachine = json['is_machine'];
    cropVariety = json['crop_variety'];
    areaAcrs = json['area_acrs'];
    plantationSystem = json['plantation_system'];
    plantattionRatooningDate = json['plantattion_ratooning_date'];
    basalDate = json['basal_date'];
    irrigationSource = json['irrigation_source'];
    irrigationMethod = json['irrigation_method'];
    developmentPlot = json['development_plot'];
    soilType = json['soil_type'];
    seedMaterial = json['seed_material'];
    seedType = json['seed_type'];
    roadSide = json['road_side'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    city = json['city'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['season'] = this.season;
    data['plantation_status'] = this.plantationStatus;
    data['plant_name'] = this.plantName;
    data['form_number'] = this.formNumber;
    data['grower_code'] = this.growerCode;
    data['vendor_code'] = this.vendorCode;
    data['grower_name'] = this.growerName;
    data['mobile_no'] = this.mobileNo;
    data['company_name'] = this.companyName;
    data['is_kisan_card'] = this.isKisanCard;
    data['area'] = this.area;
    data['circle_office'] = this.circleOffice;
    data['country'] = this.country;
    data['taluka'] = this.taluka;
    data['district'] = this.district;
    data['route'] = this.route;
    data['states'] = this.states;
    data['route_km'] = this.routeKm;
    data['survey_number'] = this.surveyNumber;
    data['crop_type'] = this.cropType;
    data['is_machine'] = this.isMachine;
    data['crop_variety'] = this.cropVariety;
    data['area_acrs'] = this.areaAcrs;
    data['plantation_system'] = this.plantationSystem;
    data['plantattion_ratooning_date'] = this.plantattionRatooningDate;
    data['basal_date'] = this.basalDate;
    data['irrigation_source'] = this.irrigationSource;
    data['irrigation_method'] = this.irrigationMethod;
    data['development_plot'] = this.developmentPlot;
    data['soil_type'] = this.soilType;
    data['seed_material'] = this.seedMaterial;
    data['seed_type'] = this.seedType;
    data['road_side'] = this.roadSide;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['city'] = this.city;
    data['state'] = this.state;
    return data;
  }
}
