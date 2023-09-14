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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['slip_no'] = slipNo;
    data['season'] = season;
    data['branch'] = branch;
    data['plot_no'] = plotNo;
    data['farmer_code'] = farmerCode;
    data['farmer_name'] = farmerName;
    data['field_village'] = fieldVillage;
    data['cane_variety'] = caneVariety;
    data['plantation_date'] = plantationDate;
    data['survery_no'] = surveryNo;
    data['area_acre'] = areaAcre;
    data['route_name'] = routeName;
    data['distance'] = distance;
    data['burn_cane'] = burnCane;
    data['deduction'] = deduction;
    data['cartno'] = cartno;
    data['transporter_code'] = transporterCode;
    data['transporter'] = transporter;
    data['transporter_name'] = transporterName;
    data['harvester_code'] = harvesterCode;
    data['harvester_name'] = harvesterName;
    data['gang_type'] = gangType;
    data['vehicle_number'] = vehicleNumber;
    data['tolly_1'] = tolly1;
    data['tolly_2'] = tolly2;
    data['rope'] = rope;
    data['water_supplier'] = waterSupplier;
    data['water_supplier_name'] = waterSupplierName;
    data['water_share'] = waterShare;
    data['percentage'] = percentage;
    data['slip_boy'] = slipBoy;
    data['can_slip_flag'] = canSlipFlag;
    data['vehicle_type'] = vehicleType;
    return data;
  }
}
