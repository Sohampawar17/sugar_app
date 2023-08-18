class Tripsheet {
  int? name;
  int? slipNo;
  String? season;
  String? branch;
  String? plotNo;
  String? farmerCode;
  String? farmerName;
  String? fieldVillage;
  String? caneVariety;
  String? plantationDate;
  String? surveryNo;
  double? areaAcre;
  String? routeName;
  double? distance;
  String? burnCane;
  double? deduction;
  double? cartno;
  String? transporterCode;
  String? transporter;
  String? transporterName;
  String? harvesterCode;
  String? harvesterName;
  String? gangType;
  String? vehicleNumber;
  String? tolly1;
  String? tolly2;
  String? rope;
  String? waterSupplier;
  String? waterSupplierName;
  double? waterShare;
  double? percentage;
  String? slipBoy;
  int? canSlipFlag;
  String? vehicleType;

  Tripsheet(
      {this.name,
      this.slipNo,
      this.season,
      this.branch,
      this.plotNo,
      this.farmerCode,
      this.farmerName,
      this.fieldVillage,
      this.caneVariety,
      this.plantationDate,
      this.surveryNo,
      this.areaAcre,
      this.routeName,
      this.distance,
      this.burnCane,
      this.deduction,
      this.cartno,
      this.transporterCode,
      this.transporter,
      this.transporterName,
      this.harvesterCode,
      this.harvesterName,
      this.gangType,
      this.vehicleNumber,
      this.tolly1,
      this.tolly2,
      this.rope,
      this.waterSupplier,
      this.waterSupplierName,
      this.waterShare,
      this.percentage,
      this.slipBoy,
      this.canSlipFlag,
      this.vehicleType});

  Tripsheet.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slipNo = json['slip_no'];
    season = json['season'];
    branch = json['branch'];
    plotNo = json['plot_no'];
    farmerCode = json['farmer_code'];
    farmerName = json['farmer_name'];
    fieldVillage = json['field_village'];
    caneVariety = json['cane_variety'];
    plantationDate = json['plantation_date'];
    surveryNo = json['survery_no'];
    areaAcre = json['area_acre'];
    routeName = json['route_name'];
    distance = json['distance'];
    burnCane = json['burn_cane'];
    deduction = json['deduction'];
    cartno = json['cartno'];
    transporterCode = json['transporter_code'];
    transporter = json['transporter'];
    transporterName = json['transporter_name'];
    harvesterCode = json['harvester_code'];
    harvesterName = json['harvester_name'];
    gangType = json['gang_type'];
    vehicleNumber = json['vehicle_number'];
    tolly1 = json['tolly_1'];
    tolly2 = json['tolly_2'];
    rope = json['rope'];
    waterSupplier = json['water_supplier'];
    waterSupplierName = json['water_supplier_name'];
    waterShare = json['water_share'];
    percentage = json['percentage'];
    slipBoy = json['slip_boy'];
    canSlipFlag = json['can_slip_flag'];
    vehicleType = json['vehicle_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['slip_no'] = this.slipNo;
    data['season'] = this.season;
    data['branch'] = this.branch;
    data['plot_no'] = this.plotNo;
    data['farmer_code'] = this.farmerCode;
    data['farmer_name'] = this.farmerName;
    data['field_village'] = this.fieldVillage;
    data['cane_variety'] = this.caneVariety;
    data['plantation_date'] = this.plantationDate;
    data['survery_no'] = this.surveryNo;
    data['area_acre'] = this.areaAcre;
    data['route_name'] = this.routeName;
    data['distance'] = this.distance;
    data['burn_cane'] = this.burnCane;
    data['deduction'] = this.deduction;
    data['cartno'] = this.cartno;
    data['transporter_code'] = this.transporterCode;
    data['transporter'] = this.transporter;
    data['transporter_name'] = this.transporterName;
    data['harvester_code'] = this.harvesterCode;
    data['harvester_name'] = this.harvesterName;
    data['gang_type'] = this.gangType;
    data['vehicle_number'] = this.vehicleNumber;
    data['tolly_1'] = this.tolly1;
    data['tolly_2'] = this.tolly2;
    data['rope'] = this.rope;
    data['water_supplier'] = this.waterSupplier;
    data['water_supplier_name'] = this.waterSupplierName;
    data['water_share'] = this.waterShare;
    data['percentage'] = this.percentage;
    data['slip_boy'] = this.slipBoy;
    data['can_slip_flag'] = this.canSlipFlag;
    data['vehicle_type'] = this.vehicleType;
    return data;
  }
}
