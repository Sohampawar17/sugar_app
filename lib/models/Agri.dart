class Agri {
  String? name;
  String? season;
  String? caneRegistrationId;
  String? supplier;
  String? growerName;
  String? village;
  String? branch;
  String? cropType;
  String? cropVariety;
  String? date;
  double? area;
  String? route;
  double? developmentArea;
  int? basel;
  int? preEarthing;
  int? earth;
  int? rainy;
  int? ratoon1;
  int? ratoon2;
  List<AgricultureDevelopmentItem>? agricultureDevelopmentItem;
  List<Grantor>? grantor;

  Agri(
      {this.name,
      this.season,
      this.caneRegistrationId,
      this.supplier,
      this.growerName,
      this.village,
      this.branch,
      this.cropType,
      this.cropVariety,
      this.date,
      this.area,
      this.route,
      this.developmentArea,
      this.basel,
      this.preEarthing,
      this.earth,
      this.rainy,
      this.ratoon1,
      this.ratoon2,
      this.agricultureDevelopmentItem,
      this.grantor});

  Agri.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    season = json['season'];
    caneRegistrationId = json['cane_registration_id'];
    supplier = json['supplier'];
    growerName = json['grower_name'];
    village = json['village'];
    branch = json['branch'];
    cropType = json['crop_type'];
    cropVariety = json['crop_variety'];
    date = json['date'];
    area = json['area'];
    route = json['route'];
    developmentArea = json['development_area'];
    basel = json['basel'];
    preEarthing = json['pre_earthing'];
    earth = json['earth'];
    rainy = json['rainy'];
    ratoon1 = json['ratoon_1'];
    ratoon2 = json['ratoon_2'];
    if (json['agriculture_development_item'] != null) {
      agricultureDevelopmentItem = <AgricultureDevelopmentItem>[];
      json['agriculture_development_item'].forEach((v) {
        agricultureDevelopmentItem!
            .add(new AgricultureDevelopmentItem.fromJson(v));
      });
    }
    if (json['grantor'] != null) {
      grantor = <Grantor>[];
      json['grantor'].forEach((v) {
        grantor!.add(new Grantor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['season'] = this.season;
    data['cane_registration_id'] = this.caneRegistrationId;
    data['supplier'] = this.supplier;
    data['grower_name'] = this.growerName;
    data['village'] = this.village;
    data['branch'] = this.branch;
    data['crop_type'] = this.cropType;
    data['crop_variety'] = this.cropVariety;
    data['date'] = this.date;
    data['area'] = this.area;
    data['route'] = this.route;
    data['development_area'] = this.developmentArea;
    data['basel'] = this.basel;
    data['pre_earthing'] = this.preEarthing;
    data['earth'] = this.earth;
    data['rainy'] = this.rainy;
    data['ratoon_1'] = this.ratoon1;
    data['ratoon_2'] = this.ratoon2;
    if (this.agricultureDevelopmentItem != null) {
      data['agriculture_development_item'] =
          this.agricultureDevelopmentItem!.map((v) => v.toJson()).toList();
    }
    if (this.grantor != null) {
      data['grantor'] = this.grantor!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AgricultureDevelopmentItem {
  String? itemCode;
  String? itemName;
  double? basel;
  double? preEarthing;
  double? earth;
  double? rainy;
  double? ratoon1;
  double? ratoon2;
  double? qty;
  String? description;
  String? stockUom;
  double? rate;
  String? parentfield;
  String? parenttype;

  AgricultureDevelopmentItem(
      {this.itemCode,
      this.itemName,
      this.basel,
      this.preEarthing,
      this.earth,
      this.rainy,
      this.ratoon1,
      this.ratoon2,
      this.qty,
      this.description,
      this.stockUom,
      this.rate,
      this.parentfield,
      this.parenttype});

  AgricultureDevelopmentItem.fromJson(Map<String, dynamic> json) {
    itemCode = json['item_code'];
    itemName = json['item_name'];
    basel = json['basel'];
    preEarthing = json['pre_earthing'];
    earth = json['earth'];
    rainy = json['rainy'];
    ratoon1 = json['ratoon_1'];
    ratoon2 = json['ratoon_2'];
    qty = json['qty'];
    description = json['description'];
    stockUom = json['stock_uom'];
    rate = json['rate'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['basel'] = this.basel;
    data['pre_earthing'] = this.preEarthing;
    data['earth'] = this.earth;
    data['rainy'] = this.rainy;
    data['ratoon_1'] = this.ratoon1;
    data['ratoon_2'] = this.ratoon2;
    data['qty'] = this.qty;
    data['description'] = this.description;
    data['stock_uom'] = this.stockUom;
    data['rate'] = this.rate;
    data['parentfield'] = this.parentfield;
    data['parenttype'] = this.parenttype;
    return data;
  }
}

class Grantor {
  String? suretyCode;
  String? suretyName;
  String? parentfield;
  String? parenttype;

  Grantor(
      {this.suretyCode, this.suretyName, this.parentfield, this.parenttype});

  Grantor.fromJson(Map<String, dynamic> json) {
    suretyCode = json['surety_code'];
    suretyName = json['surety_name'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['surety_code'] = this.suretyCode;
    data['surety_name'] = this.suretyName;
    data['parentfield'] = this.parentfield;
    data['parenttype'] = this.parenttype;
    return data;
  }
}
