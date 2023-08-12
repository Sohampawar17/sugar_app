class Agri {
  String? name;
  String? season;
  String? caneRegistrationId;
  String? supplier;
  String? vendorCode;
  String? growerName;
  String? village;
  String? branch;
  String? cropType;
  String? cropVariety;
  String? date;
  double? area;
  double? developmentArea;
  String? route;
  int? basel;
  int? preEarthing;
  int? earth;
  int? rainy;
  int? ratoon1;
  int? ratoon2;

  Agri(
      {this.name,
      this.season,
      this.caneRegistrationId,
      this.supplier,
      this.vendorCode,
      this.growerName,
      this.village,
      this.branch,
      this.cropType,
      this.cropVariety,
      this.date,
      this.area,
      this.developmentArea,
      this.route,
      this.basel,
      this.preEarthing,
      this.earth,
      this.rainy,
      this.ratoon1,
      this.ratoon2});

  Agri.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    season = json['season'];
    caneRegistrationId = json['cane_registration_id'];
    supplier = json['supplier'];
    vendorCode = json['vendor_code'];
    growerName = json['grower_name'];
    village = json['village'];
    branch = json['branch'];
    cropType = json['crop_type'];
    cropVariety = json['crop_variety'];
    date = json['date'];
    area = json['area'];
    developmentArea = json['development_area'];
    route = json['route'];
    basel = json['basel'];
    preEarthing = json['pre_earthing'];
    earth = json['earth'];
    rainy = json['rainy'];
    ratoon1 = json['ratoon_1'];
    ratoon2 = json['ratoon_2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['season'] = this.season;
    data['cane_registration_id'] = this.caneRegistrationId;
    data['supplier'] = this.supplier;
    data['vendor_code'] = this.vendorCode;
    data['grower_name'] = this.growerName;
    data['village'] = this.village;
    data['branch'] = this.branch;
    data['crop_type'] = this.cropType;
    data['crop_variety'] = this.cropVariety;
    data['date'] = this.date;
    data['area'] = this.area;
    data['development_area'] = this.developmentArea;
    data['route'] = this.route;
    data['basel'] = this.basel;
    data['pre_earthing'] = this.preEarthing;
    data['earth'] = this.earth;
    data['rainy'] = this.rainy;
    data['ratoon_1'] = this.ratoon1;
    data['ratoon_2'] = this.ratoon2;
    return data;
  }
}
